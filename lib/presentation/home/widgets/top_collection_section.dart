import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/BLoC/ProductBLoC/ProductBLoC.dart';
import '../../resources/styles_manager.dart';

class TopCollectionSection extends StatelessWidget {
  final String selectedCategory;

  const TopCollectionSection({super.key, required this.selectedCategory});

  List<Product?> _getCategoryProducts(ProductState state, String category) {
    List<Product?> products = [];
    if (state is AllProductsLoaded) {
      products = state.products;
    } else if (state is SpecificProducts) {
      products = state.products;
    } else if (state is initialState) {
      products = state.products;
    }

    return products.where((p) => p?.ProductCategotry == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBLoC, ProductState>(
      builder: (context, state) {
        final categoryProducts = _getCategoryProducts(state, selectedCategory);
        final collectionProducts = categoryProducts.length > 4
            ? categoryProducts.sublist(4, categoryProducts.length > 8 ? 8 : categoryProducts.length)
            : (categoryProducts.length > 1 ? categoryProducts.sublist(1) : []);

        if (collectionProducts.isEmpty) {
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
                    "Top Collection",
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
            _buildCollectionItems(collectionProducts),
          ],
        );
      },
    );
  }

  Widget _buildCollectionItems(List<dynamic> collectionProducts) {
    return Column(
      children: [
        if (collectionProducts.isNotEmpty)
          _buildCollectionItem(
            collectionProducts[0]!.getDisplayImage(),
            height: 141.h,
          ),
        if (collectionProducts.length >= 2) ...[
          SizedBox(height: 15.h),
          _buildCollectionItem(
            collectionProducts[1]!.getDisplayImage(),
            height: 229.h,
          ),
        ],
        if (collectionProducts.length >= 4) ...[
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: _buildCollectionItem(
                  collectionProducts[2]!.getDisplayImage(),
                  height: 194.h,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: _buildCollectionItem(
                  collectionProducts[3]!.getDisplayImage(),
                  height: 194.h,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildCollectionItem(String imageUrl, {required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: height,
              width: double.infinity,
              color: ColorManager.lighterGrayLight.withOpacity(0.3),
              child: Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: double.infinity,
              color: ColorManager.lighterGrayLight.withOpacity(0.3),
              child: Icon(
                Icons.image_not_supported,
                size: AppSize.s20,
                color: ColorManager.lightGrayLight,
              ),
            );
          },
        ),
      ),
    );
  }
}