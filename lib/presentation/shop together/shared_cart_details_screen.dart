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

  // Caches for metadata and product objects
  final Map<String, String> _productNames = {};
  final Map<String, String> _userNames = {};
  final Map<String, Product> _products = {};

  // Track whether metadata for current cart items is loaded
  bool _metaLoading = false;
  String? _metaLoadedForCartId;

  bool get _isOwner => _auth.currentUser?.uid == widget.cart.owner;
  bool get _isCollaborator =>
      widget.cart.collabs.contains(_auth.currentUser?.uid);

  @override
  void initState() {
    super.initState();
    // Trigger items load once when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SharedCartBloc>().add(LoadSharedCartItems(widget.cart.id));
    });
  }

  Future<String> _getProductName(String productId) async {
    if (_productNames.containsKey(productId)) return _productNames[productId]!;
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final data = doc.data()!;
        final name = (data['ProductName'] as String?) ?? 'Unknown Product';
        _productNames[productId] = name;
        return name;
      }
      return 'Product Not Found';
    } catch (_) {
      return 'Error Loading Product';
    }
  }

  Future<Product?> _getProduct(String productId) async {
    if (_products.containsKey(productId)) return _products[productId];
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final product =
        Product.fromJson({...doc.data()!, 'id': doc.id} as Map<String, dynamic>);
        _products[productId] = product;
        return product;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<String> _getUserName(String userId) async {
    if (_userNames.containsKey(userId)) return _userNames[userId]!;
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      final name = (doc.data()?['name'] as String?) ?? 'User';
      _userNames[userId] = name;
      return name;
    } catch (_) {
      return 'User';
    }
  }

  /// Preload product names & user names (and product objects) for given items.
  /// This runs when SharedCartItemsLoaded arrives and caches metadata so UI renders synchronously.
  Future<void> _preloadMetaForItems(String cartId, List<SharedCartItem> items) async {
    // Skip if we've already loaded meta for this cart
    if (_metaLoadedForCartId == cartId) return;

    _metaLoading = true;
    if (mounted) setState(() {});

    try {
      final productIds = <String>{};
      final userIds = <String>{};
      for (var item in items) {
        productIds.add(item.productId);
        userIds.add(item.addedBy);
      }

      // fetch names in parallel
      final productNameFutures = productIds.map((id) => _getProductName(id));
      final userNameFutures = userIds.map((id) => _getUserName(id));
      await Future.wait([
        Future.wait(productNameFutures),
        Future.wait(userNameFutures),
      ]);

      // also preload full Product objects for checkout
      final productObjFutures = productIds.map((id) => _getProduct(id));
      await Future.wait(productObjFutures);
    } catch (_) {
      // swallow; we'll display fallback strings
    } finally {
      _metaLoading = false;
      _metaLoadedForCartId = cartId;
      if (mounted) setState(() {});
    }
  }

  void _deleteItem(SharedCartItem item) {
    if (item.id == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteItem),
        content: Text(S.of(context).areYouSureYouWantToRemoveItem),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel)),
          TextButton(
            onPressed: () {
              context.read<SharedCartBloc>().add(
                RemoveItemFromSharedCart(cartId: widget.cart.id, itemId: item.id!),
              );
              Navigator.pop(context);
            },
            child: Text(S.of(context).delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _proceedToCheckout(List<SharedCartItem> items) async {
    final List<CartItem> cartItems = [];
    for (final sharedItem in items) {
      final product = await _getProduct(sharedItem.productId);
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).noValidProductsToCheckout)),
        );
      }
      return;
    }

    if (!mounted) return;

    Navigator.pushNamed(
      context,
      Routes.checkoutRoute,
      arguments: {
        'cartItems': cartItems,
        'sharedCartId': widget.cart.id,
      },
    );
  }

  void _handleDeleteCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteCart),
        content: Text(S.of(context).areYouSureYouWantToDeleteCart),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel)),
          TextButton(
            onPressed: () {
              context.read<SharedCartBloc>().add(DeleteSharedCart(widget.cart.id));
              Navigator.pop(context);
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
      builder: (context) => AlertDialog(
        title: Text(S.of(context).leaveCart),
        content: Text(S.of(context).areYouSureYouWantToLeaveCart),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(S.of(context).cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SharedCartBloc>().add(RemoveCollaborator(cartId: widget.cart.id, userId: userId));
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context).cartLeft)),
                );
                Navigator.pop(context);
              }
            },
            child: Text(S.of(context).leaveCart, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(List<SharedCartItem> items) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              // Use cached metadata (synchronous)
              final productName = _productNames[item.productId] ?? S.of(context).loading;
              final userName = _userNames[item.addedBy] ?? S.of(context).user;

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
                      Text(
                        '${S.of(context).addedBy} $userName',
                        style: TextStyle(
                          fontFamily: FontConstants.fontFamily,
                          fontSize: 12.sp,
                          color: ColorManager.lightGrayLight,
                        ),
                      ),
                      Text(
                        '${S.of(context).quantity}: ${item.quantity}',
                        style: TextStyle(
                          fontFamily: FontConstants.fontFamily,
                          fontSize: 12.sp,
                          color: ColorManager.lightGrayLight,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _deleteItem(item),
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
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, -2)),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryLight,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => _proceedToCheckout(items),
              child: Text(
                S.of(context).proceedToCheckout,
                style: TextStyle(
                  fontFamily: FontConstants.fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeightManager.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

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
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87)),
        actions: [
          if (_isOwner)
            IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: _handleDeleteCart, tooltip: S.of(context).deleteCart)
          else if (_isCollaborator)
            IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.red), onPressed: _handleLeaveCart, tooltip: S.of(context).leaveCart),
        ],
      ),
      body: BlocConsumer<SharedCartBloc, SharedCartState>(
        listener: (context, state) {
          if (state is SharedCartItemsLoaded && state.cartId == widget.cart.id) {
            // Preload metadata once for items when they're loaded
            _preloadMetaForItems(state.cartId, state.items);
          } else if (state is SharedCartDeleted) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).cartDeleted)));
              Navigator.pop(context);
            }
          } else if (state is SharedCartError) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          }
        },
        builder: (context, state) {
          // If bloc says loading globally (e.g., create/delete operations) show spinner
          if (state is SharedCartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // When items loaded for this cart:
          if (state is SharedCartItemsLoaded && state.cartId == widget.cart.id) {
            final items = state.items;

            // If no items show placeholder
            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 64, color: ColorManager.lightGrayLight),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).noItemsInThisCartYet,
                      style: TextStyle(color: ColorManager.lightGrayLight, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            // If metadata still loading, show spinner until cached names available
            if (_metaLoading || _metaLoadedForCartId != widget.cart.id) {
              return const Center(child: CircularProgressIndicator());
            }

            // Meta loaded -> render list
            return _buildItemsList(items);
          }

          // Default: show spinner while waiting for initial items load
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
