import 'package:depi_graduation/data/models/ProductModel.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/styles_manager.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final double width;
  final double imageHeight;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.width = 120,
    this.imageHeight = 190,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                product.getDisplayImage(),
                height: imageHeight.h,
                width: width.w,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: imageHeight.h,
                    width: width.w,
                    color: ColorManager.lighterGrayLight.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: imageHeight.h,
                  width: width.w,
                  color: ColorManager.lighterGrayLight.withOpacity(0.3),
                  child: Icon(
                    Icons.image_not_supported,
                    size: AppSize.s32,
                    color: ColorManager.lightGrayLight,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              product.ProductName,
              style: regularStyle(
                color: ColorManager.primaryLight,
                fontSize: FontSize.s12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "\$${product.ProductPrice.toStringAsFixed(2)}",
              style: boldStyle(
                color: ColorManager.primaryLight,
                fontSize: FontSize.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}