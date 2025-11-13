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
import '../../resources/styles_manager.dart';
class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

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
        List<Product?> products = _getProductsFromState(state);
        final recommendedProducts = products.take(3).toList();

        if (recommendedProducts.isEmpty) {
          return SizedBox.shrink();
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended",
                    style: boldStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.darkGrayLight,
                    ),
                  ),
                  Text(
                    "Show all",
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
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedProducts.length,
                itemBuilder: (context, index) {
                  final product = recommendedProducts[index];
                  if (product == null) return SizedBox.shrink();

                  return _buildRecommendedProductCard(context, product);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecommendedProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetailsRoute,
          arguments: product.ProductID,
        );
      },
      child: Container(
        width: 213.w,
        margin: EdgeInsets.only(right: AppMargin.m12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorManager.lighterGrayLight.withOpacity(0.5),
            width: 0.5.w,
          ),
          color: ColorManager.whiteLight,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: Image.network(
                product.getDisplayImage(),
                height: 100.h,
                width: 66.w,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 100.h,
                    width: 66.w,
                    color: ColorManager.lighterGrayLight.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100.h,
                  width: 66.w,
                  color: ColorManager.lighterGrayLight.withOpacity(0.3),
                  child: Icon(
                    Icons.image_not_supported,
                    size: AppSize.s20,
                    color: ColorManager.lightGrayLight,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.ProductName,
                    style: regularStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.primaryLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "\$${product.ProductPrice.toStringAsFixed(2)}",
                    style: boldStyle(
                      color: ColorManager.primaryLight,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}