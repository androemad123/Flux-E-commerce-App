import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/BLoC/ProductBLoC/ProductBLoC.dart';
import '../../resources/styles_manager.dart';

class CategorySection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategorySelected;

   CategorySection({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final List<IconData> categoryIcons = [
    Icons.female,
    Icons.male,
    Icons.watch,
    Icons.brush_rounded,
  ];

  final List<String> categoryNames = ["Women", "Men", "Accessories", "Beauty"];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(categoryIcons.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            onCategorySelected(index);
            context.read<ProductBLoC>().add(LoadCategoryProduct(ProductCategotry: categoryNames[index]));
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: ColorManager.primaryLight, width: 2.w)
                      : null,
                ),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? ColorManager.primaryLight
                        : ColorManager.lighterGrayLight.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Icon(
                      categoryIcons[index],
                      color: isSelected ? ColorManager.whiteLight : ColorManager.primaryLight,
                      size: AppSize.s20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                categoryNames[index],
                style: isSelected
                    ? boldStyle(fontSize: FontSize.s12, color: ColorManager.primaryLight)
                    : regularStyle(fontSize: FontSize.s12, color: ColorManager.lighterGrayLight),
              ),
            ],
          ),
        );
      }),
    );
  }
}