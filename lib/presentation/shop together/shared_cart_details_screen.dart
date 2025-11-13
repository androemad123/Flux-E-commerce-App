import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class SharedCartDetailsScreen extends StatefulWidget {
  final SharedCart cart;

  const SharedCartDetailsScreen({
    super.key,
    required this.cart,
  });

  @override
  State<SharedCartDetailsScreen> createState() => _SharedCartDetailsScreenState();
}

class _SharedCartDetailsScreenState extends State<SharedCartDetailsScreen> {
  final _firestore = FirebaseFirestore.instance;
  final Map<String, String> _productNames = {}; // Cache for product names
  final Map<String, String> _userNames = {}; // Cache for user names
  final Map<String, Product> _products = {}; // Cache for full product data

  @override
  void initState() {
    super.initState();
    // Load items when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SharedCartBloc>().add(LoadSharedCartItems(widget.cart.id));
    });
  }

  Future<String> _getProductName(String productId) async {
    if (_productNames.containsKey(productId)) {
      return _productNames[productId]!;
    }
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final data = doc.data()!;
        final name = data['ProductName'] as String? ?? 'Unknown Product';
        _productNames[productId] = name;
        return name;
      }
      return 'Product Not Found';
    } catch (e) {
      return 'Error Loading Product';
    }
  }

  Future<Product?> _getProduct(String productId) async {
    if (_products.containsKey(productId)) {
      return _products[productId];
    }
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final product = Product.fromJson({...doc.data()!, 'id': doc.id});
        _products[productId] = product;
        return product;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> _getUserName(String userId) async {
    if (_userNames.containsKey(userId)) {
      return _userNames[userId]!;
    }
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      final name = doc.data()?['name'] as String? ?? 'User';
      _userNames[userId] = name;
      return name;
    } catch (e) {
      return 'User';
    }
  }

  void _deleteItem(SharedCartItem item) {
    if (item.id == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to remove this item from the cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SharedCartBloc>().add(
                RemoveItemFromSharedCart(cartId: widget.cart.id, itemId: item.id!),
              );
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _proceedToCheckout(List<SharedCartItem> items) async {
    // Convert shared cart items to cart items
    final List<CartItem> cartItems = [];

    for (final sharedItem in items) {
      final product = await _getProduct(sharedItem.productId);
      if (product != null) {
        cartItems.add(
          CartItem(
            product: product,
            quantity: sharedItem.quantity,
            selectedColor: null,
            selectedSize: null,
          ),
        );
      }
    }

    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No valid products to checkout')),
      );
      return;
    }

    // Navigate to checkout screen with cart items and shared cart ID as arguments
    Navigator.pushNamed(
      context,
      Routes.checkoutRoute,
      arguments: {
        'cartItems': cartItems,
        'sharedCartId': widget.cart.id,
      },
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
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black87,)),
      ),
      body: BlocConsumer<SharedCartBloc, SharedCartState>(
        listener: (context, state) {
          if (state is SharedCartUpdated) {
            // Reload items after update
            context.read<SharedCartBloc>().add(LoadSharedCartItems(widget.cart.id));
          }
        },
        builder: (context, state) {
          if (state is SharedCartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SharedCartItemsLoaded && state.cartId == widget.cart.id) {
            final items = state.items;
            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 64, color: ColorManager.lightGrayLight),
                    const SizedBox(height: 16),
                    Text(
                      "No items in this cart yet",
                      style: TextStyle(
                        color: ColorManager.lightGrayLight,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return FutureBuilder<Map<String, String>>(
                        future: Future.wait([
                          _getProductName(item.productId),
                          _getUserName(item.addedBy),
                        ]).then((results) => {
                          'productName': results[0],
                          'userName': results[1],
                        }),
                        builder: (context, snapshot) {
                          final productName = snapshot.data?['productName'] ?? 'Loading...';
                          final userName = snapshot.data?['userName'] ?? 'User';

                          return Card(
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
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
                                    'Added by: $userName',
                                    style: TextStyle(
                                      fontFamily: FontConstants.fontFamily,
                                      fontSize: 12.sp,
                                      color: ColorManager.lightGrayLight,
                                    ),
                                  ),
                                  Text(
                                    'Quantity: ${item.quantity}',
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
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _proceedToCheckout(items),
                      child: Text(
                        'Proceed to Checkout',
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

          // Load items when screen opens
          if (state is! SharedCartItemsLoaded || state.cartId != widget.cart.id) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<SharedCartBloc>().add(LoadSharedCartItems(widget.cart.id));
            });
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
