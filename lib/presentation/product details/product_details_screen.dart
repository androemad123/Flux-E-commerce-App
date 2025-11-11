import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/ProductName&Price.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/imageSlider.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productDetailsAppBar.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productDiscription.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/productReviews.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/product_color_size.dart';
import 'package:depi_graduation/presentation/product%20details/subScreens/starsRating.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<ProductBLoC>().add(LoadProduct(ProductID: widget.productId));
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

                              const product_color_size(
                                clrs: [Colors.red, Colors.black, Colors.blue],
                                txt: ["S", "M", "L"],
                              ),
                              const SizedBox(height: 10),
                              const Divider(thickness: 0.1, height: 0.5),

                              Productdiscription(productID: product.ProductID),
                              const SizedBox(height: 5),
                              const Divider(thickness: 0.1, height: 0.5),

                              const Productreviews(
                                numOfRatings: 83,
                                ratingNumber: "4.9",
                                numOfReviews: 47,
                                nums: [5, 4, 3, 2, 1],
                                percentages: [.80, .12, .05, .03, 0],
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ Add button at bottom
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: SizedBox(
                      width: double.infinity,
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
                          print("Add to cart pressed");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 25,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: FontConstants.fontFamily,
                                color:
                                Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("Loading product..."));
        },
      ),
    );
  }
}
