import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/BLoC/ProductBLoC/ProductBLoC.dart';
import '../../../routing/routes.dart';
import '../../../generated/l10n.dart';
import '../../resources/styles_manager.dart';
import 'product_card.dart';

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({super.key});

  List<Product?> _getProductsFromState(ProductState state) {
    if (state is AllProductsLoaded) {
      return state.products;
    } else if (state is SpecificProducts) {
      return state.products;
    } else if (state is initialState) {
      return state.products;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBLoC, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ErrorState) {
          return Padding(
            padding: EdgeInsets.all(AppPadding.p12),
            child: Center(
              child: Text(
                state.errorMSG,
                style: regularStyle(
                  color: ColorManager.darkGrayLight,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          );
        }

        List<Product?> products = _getProductsFromState(state);
        final featuredProducts = products.take(10).toList();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).featuredProducts,
                    style: boldStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.darkGrayLight,
                    ),
                  ),
                  Text(
                    S.of(context).showAll,
                    style: regularStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.lightGrayLight,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 277.h,
              child: featuredProducts.isEmpty
                  ? _buildEmptyState(context)
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = featuredProducts[index];
                  if (product == null) return SizedBox.shrink();

                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.productDetailsRoute,
                        arguments: product.ProductID,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: Text(
          S.of(context).noFeaturedProductsFound,
          style: regularStyle(
            color: ColorManager.lightGrayLight,
            fontSize: FontSize.s12,
          ),
        ),
      ),
    );
  }
}