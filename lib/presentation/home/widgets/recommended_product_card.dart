import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/ProductModel.dart';
import '../../../presentation/resources/color_manager.dart';
import '../../../presentation/resources/styles_manager.dart';
import '../../../presentation/resources/value_manager.dart';
import '../../../routing/routes.dart';
import '../../resources/font_manager.dart';

class RecommendedProductCard extends StatelessWidget {
  final Product product;

  const RecommendedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.productDetailsRoute,
        arguments: product.ProductID,
      ),
      child: Container(
        width: 130.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: ColorManager.whiteLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSize.s12),
              ),
              child: Image.network(
                product.getDisplayImage(),
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _errorImage(),
                loadingBuilder: (context, child, progress) =>
                progress == null ? child : _loadingImage(),
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.ProductName,
                    style: boldStyle(
                      color: ColorManager.primaryLight,
                      fontSize: FontSize.s12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "\$${product.ProductPrice.toStringAsFixed(2)}",
                    style: regularStyle(
                      color: ColorManager.lightGrayLight,
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

  Widget _errorImage() => Container(
    height: 150.h,
    color: ColorManager.lighterGrayLight.withOpacity(0.3),
    child: Icon(Icons.image_not_supported,
        color: ColorManager.lightGrayLight, size: AppSize.s32),
  );

  Widget _loadingImage() => Container(
    height: 150.h,
    color: ColorManager.lighterGrayLight.withOpacity(0.3),
    child: const Center(child: CircularProgressIndicator()),
  );
}
