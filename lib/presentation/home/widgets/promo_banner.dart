import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductState.dart';
import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/BLoC/ProductBLoC/ProductBLoC.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

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

        if (products.isEmpty) {
          return SizedBox.shrink();
        }

        final promoProduct = products.first;
        if (promoProduct == null) return SizedBox.shrink();

        return Container(
          width: double.infinity,
          height: 158.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              promoProduct.getDisplayImage(),
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 158.h,
                  width: double.infinity,
                  color: ColorManager.lighterGrayLight.withOpacity(0.3),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 158.h,
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
          ),
        );
      },
    );
  }
}