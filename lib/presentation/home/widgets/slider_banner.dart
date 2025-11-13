import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/BLoC/ProductBLoC/ProductBLoC.dart';
import '../../resources/font_manager.dart';

class SliderBanner extends StatefulWidget {
  final String selectedCategory;

  const SliderBanner({super.key, required this.selectedCategory});

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  int _currentImg = 0;

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
        final categoryProducts = _getCategoryProducts(state, widget.selectedCategory);
        final sliderImages = categoryProducts
            .take(4)
            .map((p) => p?.getDisplayImage() ?? '')
            .where((image) => image.isNotEmpty)
            .toList();

        if (sliderImages.isEmpty) {
          return _buildEmptyState(state);
        }

        return Container(
          height: 312.h,
          width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: sliderImages.length,
                onPageChanged: (img) => setState(() => _currentImg = img),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      sliderImages[index],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 312.h,
                          width: double.infinity,
                          color: ColorManager.lighterGrayLight.withOpacity(0.3),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 312.h,
                          width: double.infinity,
                          color: ColorManager.lighterGrayLight.withOpacity(0.3),
                          child: Icon(
                            Icons.image_not_supported,
                            size: AppSize.s32,
                            color: ColorManager.lightGrayLight,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (sliderImages.length > 1) _buildPageIndicator(sliderImages.length),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator(int length) {
    return Positioned(
      bottom: 20.h,
      left: 0,
      right: 0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (index) {
            final isActive = _currentImg == index;
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: AppMargin.m4),
              width: isActive ? 16.w : 8.w,
              height: isActive ? 16.h : 8.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: ColorManager.whiteLight, width: 1.w),
              ),
              child: Center(
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: ColorManager.whiteLight,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ProductState state) {
    return Container(
      height: 312.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorManager.lighterGrayLight.withOpacity(0.3),
      ),
      child: Center(
        child: state is ProductLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, size: AppSize.s32, color: ColorManager.lightGrayLight),
            SizedBox(height: 8.h),
            Text(
              'No products available',
              style: TextStyle(
                fontSize: FontSize.s12,
                color: ColorManager.lightGrayLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}