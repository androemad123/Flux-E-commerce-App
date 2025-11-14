import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/BLoC/SharedCartBLoC/shared_cart_bloc.dart';
import '../../app/BLoC/SharedCartBLoC/shared_cart_event.dart';
import '../../app/BLoC/SharedCartBLoC/shared_cart_state.dart';
import '../../data/models/ProductModel.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/shared_cart.dart';
import '../../data/models/shared_cart_item.dart';
import '../../routing/routes.dart';
import '../../generated/l10n.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class SharedCartDetailsScreen extends StatefulWidget {
  final SharedCart cart;

  const SharedCartDetailsScreen({
    super.key,
    required this.cart,
  });

  @override
  State<SharedCartDetailsScreen> createState() =>
      _SharedCartDetailsScreenState();
}

class _SharedCartDetailsScreenState extends State<SharedCartDetailsScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // cached metadata & products
  final Map<String, String> _productNames = {};
  final Map<String, String> _userNames = {};
  final Map<String, Product> _products = {};

  // local copy of items for this screen (populated from bloc's ItemsLoaded)
  List<SharedCartItem>? _items;

  // meta loading state for product/user names and product objects
  bool _metaLoading = false;
  String? _metaLoadedForCartId;

  bool get _isOwner => _auth.currentUser?.uid == widget.cart.owner;
  bool get _isCollaborator =>
      widget.cart.collabs.contains(_auth.currentUser?.uid);

  @override
  void initState() {
    super.initState();
    // Request items once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SharedCartBloc>().add(LoadSharedCartItems(widget.cart.id));
    });
  }

  Future<void> _preloadMetaForItems(String cartId, List<SharedCartItem> items) async {
    // Skip if already loaded meta for this cart id
    if (_metaLoadedForCartId == cartId) return;

    _metaLoading = true;
    if (mounted) setState(() {});

    try {
      final productIds = <String>{};
      final userIds = <String>{};
      for (final it in items) {
        productIds.add(it.productId);
        userIds.add(it.addedBy);
      }

      // fetch all product names & user names in parallel
      final productNameFutures = productIds.map((id) => _fetchAndCacheProductName(id));
      final userNameFutures = userIds.map((id) => _fetchAndCacheUserName(id));
      await Future.wait([
        Future.wait(productNameFutures),
        Future.wait(userNameFutures),
      ]);

      // preload full Product objects (for checkout) in parallel
      final productObjFutures = productIds.map((id) => _fetchAndCacheProductObj(id));
      await Future.wait(productObjFutures);
    } catch (_) {
      // ignore and fall back to placeholders
    } finally {
      _metaLoading = false;
      _metaLoadedForCartId = cartId;
      if (mounted) setState(() {});
    }
  }

  Future<void> _fetchAndCacheProductName(String productId) async {
    if (_productNames.containsKey(productId)) return;
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      final name = (doc.data()?['ProductName'] as String?) ?? S.of(context).loading;
      _productNames[productId] = name;
    } catch (_) {
      _productNames[productId] = S.of(context).loading;
    }
  }

  Future<void> _fetchAndCacheUserName(String userId) async {
    if (_userNames.containsKey(userId)) return;
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      final name = (doc.data()?['name'] as String?) ?? S.of(context).user;
      _userNames[userId] = name;
    } catch (_) {
      _userNames[userId] = S.of(context).user;
    }
  }

  Future<void> _fetchAndCacheProductObj(String productId) async {
    if (_products.containsKey(productId)) return;
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final json = {...doc.data()!, 'id': doc.id} as Map<String, dynamic>;
        final product = Product.fromJson(json);
        _products[productId] = product;
      }
    } catch (_) {
      // ignore
    }
  }

  void _onRemoveItem(SharedCartItem item) {
    if (item.id == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).deleteItem),
        content: Text(S.of(context).areYouSureYouWantToRemoveItem),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(S.of(context).cancel)),
          TextButton(
            onPressed: () {
              context.read<SharedCartBloc>().add(
                RemoveItemFromSharedCart(cartId: widget.cart.id, itemId: item.id!),
              );
              Navigator.pop(ctx);
            },
            child: Text(S.of(context).delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _proceedToCheckout() async {
    final items = _items ?? [];
    final List<CartItem> cartItems = [];

    for (final sharedItem in items) {
      final product = _products[sharedItem.productId] ?? await _fetchProductOnTheFly(sharedItem.productId);
      if (product != null) {
        cartItems.add(CartItem(
          product: product,
          quantity: sharedItem.quantity,
          selectedColor: null,
          selectedSize: null,
        ));
      }
    }

    if (cartItems.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).noValidProductsToCheckout)));
      }
      return;
    }

    if (!mounted) return;
    Navigator.pushNamed(context, Routes.checkoutRoute, arguments: {
      'cartItems': cartItems,
      'sharedCartId': widget.cart.id,
    });
  }

  Future<Product?> _fetchProductOnTheFly(String id) async {
    try {
      final doc = await _firestore.collection('products').doc(id).get();
      if (doc.exists) {
        final product = Product.fromJson({...doc.data()!, 'id': doc.id} as Map<String, dynamic>);
        _products[id] = product;
        return product;
      }
    } catch (_) {}
    return null;
  }

  void _handleDeleteCart() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).deleteCart),
        content: Text(S.of(context).areYouSureYouWantToDeleteCart),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(S.of(context).cancel)),
          TextButton(
            onPressed: () {
              context.read<SharedCartBloc>().add(DeleteSharedCart(widget.cart.id));
              Navigator.pop(ctx);
            },
            child: Text(S.of(context).delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _handleLeaveCart() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).leaveCart),
        content: Text(S.of(context).areYouSureYouWantToLeaveCart),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(S.of(context).cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<SharedCartBloc>().add(RemoveCollaborator(cartId: widget.cart.id, userId: userId));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).cartLeft)));
                Navigator.pop(context);
              }
            },
            child: Text(S.of(context).leaveCart, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Helper: synchronous getters for UI (use cache or fallbacks)
  String _productNameOrFallback(String productId) =>
      _productNames[productId] ?? S.of(context).loading;

  String _userNameOrFallback(String userId) => _userNames[userId] ?? S.of(context).user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.cart.name),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ColorManager.primaryLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
        ),
        actions: [
          if (_isOwner)
            IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: _handleDeleteCart, tooltip: S.of(context).deleteCart)
          else if (_isCollaborator)
            IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: _handleLeaveCart, tooltip: S.of(context).leaveCart),
        ],
      ),
      body: BlocListener<SharedCartBloc, SharedCartState>(
        listener: (context, state) async {
          // Only respond to SharedCartItemsLoaded for this cart id:
          if (state is SharedCartItemsLoaded && state.cartId == widget.cart.id) {
            _items = state.items;
            // preload metadata (names + product objects)
            await _preloadMetaForItems(state.cartId, state.items);
            if (mounted) setState(() {});
            return;
          }

          // If an update happened, request fresh items (one-time)
          if (state is SharedCartUpdated) {
            // re-request items after an update
            context.read<SharedCartBloc>().add(LoadSharedCartItems(widget.cart.id));
            return;
          }

          if (state is SharedCartDeleted) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).cartDeleted)));
              Navigator.pop(context);
            }
            return;
          }

          if (state is SharedCartError) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
            return;
          }

          // IMPORTANT: ignore other states (e.g., SharedCartsLoaded) — they are unrelated
        },
        child: Builder(builder: (context) {
          // Show loading when we have not yet received items OR when metadata is still loading
          if (_items == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // If items are empty, show placeholder
          if (_items!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: ColorManager.lightGrayLight),
                  const SizedBox(height: 16),
                  Text(S.of(context).noItemsInThisCartYet, style: TextStyle(color: ColorManager.lightGrayLight, fontSize: 16)),
                ],
              ),
            );
          }

          // If metadata for items is still loading, show spinner
          if (_metaLoading || _metaLoadedForCartId != widget.cart.id) {
            return const Center(child: CircularProgressIndicator());
          }

          // All good: render the list synchronously using cached metadata
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: _items!.length,
                  itemBuilder: (context, index) {
                    final item = _items![index];
                    final productName = _productNameOrFallback(item.productId);
                    final userName = _userNameOrFallback(item.addedBy);

                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        title: Text(
                          productName,
                          style: TextStyle(
                            fontFamily: FontConstants.fontFamily,
                            fontWeight: FontWeightManager.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('${S.of(context).addedBy} $userName',
                                style: TextStyle(
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: 12.sp,
                                  color: ColorManager.lightGrayLight,
                                )),
                            Text('${S.of(context).quantity}: ${item.quantity}',
                                style: TextStyle(
                                  fontFamily: FontConstants.fontFamily,
                                  fontSize: 12.sp,
                                  color: ColorManager.lightGrayLight,
                                )),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => _onRemoveItem(item),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Checkout button
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, -2))],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primaryLight,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _proceedToCheckout,
                    child: Text(S.of(context).proceedToCheckout, style: TextStyle(fontFamily: FontConstants.fontFamily, fontSize: 16.sp, fontWeight: FontWeightManager.bold, color: Colors.white)),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
