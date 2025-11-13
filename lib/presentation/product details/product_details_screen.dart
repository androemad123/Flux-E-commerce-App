import 'package:depi_graduation/app/BLoC/CartBLoC/cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/CartBLoC/cart_event.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_event.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_state.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/data/models/shared_cart.dart';
import 'package:depi_graduation/data/models/shared_cart_item.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/ProductName&Price.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/imageSlider.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productDetailsAppBar.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productDiscription.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productReviews.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/product_color_size.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/starsRating.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:depi_graduation/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_from_string_helper.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavourite = false;
  String? _selectedColor;
  String? _selectedSize;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    context.read<ProductBLoC>().add(LoadProduct(ProductID: widget.productId));
    // Load shared carts for the user
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      context.read<SharedCartBloc>().add(LoadSharedCarts(userId));
    }
  }

  void _showSharedCartDialog(Product product) {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<SharedCartBloc, SharedCartState>(
        builder: (context, state) {
          List<SharedCart> carts = [];
          if (state is SharedCartsLoaded) {
            carts = state.carts;
          } else if (state is SharedCartLoading) {
            return const AlertDialog(
              content: Center(child: CircularProgressIndicator()),
            );
          }

          if (carts.isEmpty) {
            return AlertDialog(
              title: Text(S.of(context).noSharedCarts),
              content: Text(S.of(context).youNeedToCreateOrJoinSharedCart),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).ok),
                ),
              ],
            );
          }

          return AlertDialog(
            title: Text(S.of(context).selectSharedCart),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: carts.length,
                itemBuilder: (context, index) {
                  final cart = carts[index];
                  final isOwner = cart.owner == _auth.currentUser?.uid;
                  return ListTile(
                    title: Text(cart.name),
                    subtitle: Text(
                      isOwner ? S.of(context).owner : S.of(context).collaborator,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _addToSharedCart(cart, product);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).cancel),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addToSharedCart(SharedCart cart, Product product) {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final item = SharedCartItem(
      productId: product.ProductID,
      quantity: 1,
      addedBy: userId,
    );

    context.read<SharedCartBloc>().add(
          AddItemToSharedCart(cartId: cart.id, item: item),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${product.ProductName} ${S.of(context).addedTo} ${cart.name}",
          style: TextStyle(
            fontFamily: FontConstants.fontFamily,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: BlocBuilder<ProductBLoC, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorState) {
            return Center(child: Text(state.errorMSG));
          }

          if (state is ProductLoaded) {
            final product = state.product;
            final availableColors = product.ProductColors ?? [];
            final availableSizes = product.ProductSizes ?? [];

            _selectedColor ??=
                availableColors.isNotEmpty ? availableColors.first : null;
            _selectedSize ??=
                availableSizes.isNotEmpty ? availableSizes.first : null;

            final colorWidgets =
                availableColors.map((c) => colorFromString(c)).toList();
            final int selectedColorIndex = (_selectedColor != null &&
                    availableColors.contains(_selectedColor!))
                ? availableColors.indexOf(_selectedColor!)
                : 0;
            final int selectedSizeIndex = (_selectedSize != null &&
                    availableSizes.contains(_selectedSize!))
                ? availableSizes.indexOf(_selectedSize!)
                : 0;

            return CustomScrollView(
              slivers: [
                // App bar stays as sliver
                sliverAppbar(
                  isFavourite: isFavourite,
                  onBack: () => Navigator.pop(context),
                  onFavouriteToggle: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                ),

                // Product content
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      imageSlider(productID: widget.productId),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppPadding.p18),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Product_Name_Price(productID: product.ProductID),
                              const SizedBox(height: 5),
                              const starsRating(rate: 0, numOfRatings: 83),
                              const SizedBox(height: 15),
                              const Divider(thickness: 0.1, height: 0.5),
                              const SizedBox(height: 10),
                              product_color_size(
                                clrs: colorWidgets,
                                txt: availableSizes,
                                selectedColorIndex: selectedColorIndex,
                                selectedSizeIndex: selectedSizeIndex,
                                onColorChanged: (index) {
                                  if (index >= 0 &&
                                      index < availableColors.length) {
                                    setState(() {
                                      _selectedColor = availableColors[index];
                                    });
                                  }
                                },
                                onSizeChanged: (index) {
                                  if (index >= 0 &&
                                      index < availableSizes.length) {
                                    setState(() {
                                      _selectedSize = availableSizes[index];
                                    });
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              const Divider(thickness: 0.1, height: 0.5),
                              Productdiscription(productID: product.ProductID),
                              const SizedBox(height: 5),
                              const Divider(thickness: 0.1, height: 0.5),
                              Productreviews(productId: product.ProductID),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ Add buttons at bottom
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Row(
                      children: [
                        // Add to Cart button
                        Expanded(
                          child: SizedBox(
                            height: 60.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSurface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                context.read<CartBloc>().add(
                                      CartItemAdded(
                                        product: product,
                                        selectedColor: _selectedColor,
                                        selectedSize: _selectedSize,
                                      ),
                                    );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${product.ProductName} ${S.of(context).addedTo} cart",
                                      style: TextStyle(
                                        fontFamily: FontConstants.fontFamily,
                                      ),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: S.of(context).viewCart,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.cartRoute);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    S.of(context).addToCart,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: FontConstants.fontFamily,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Add to Shared Cart button
                        SizedBox(
                          height: 60.h,
                          width: 60.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              _showSharedCartDialog(product);
                            },
                            child: Icon(
                              Icons.group_add,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(child: Text(S.of(context).loadingProduct));
        },
      ),
    );
  }
}
