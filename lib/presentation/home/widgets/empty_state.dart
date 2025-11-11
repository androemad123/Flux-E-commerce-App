import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../presentation/resources/color_manager.dart';
import '../../../presentation/resources/styles_manager.dart';
import '../../../presentation/resources/value_manager.dart';
import '../../resources/font_manager.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p12),
        child: Text(
          message,
          style: regularStyle(
            color: ColorManager.lightGrayLight,
            fontSize: FontSize.s12,
          ),
        ),
      ),
    );
  }
}
