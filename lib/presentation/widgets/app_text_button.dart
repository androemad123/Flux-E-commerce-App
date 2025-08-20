import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final IconData? icon; // optional icon

  const AppTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.textColor,
    this.borderRadius = 25,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width ?? 150).w,   // responsive width
      height: (height ?? 50).h, // responsive height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? ColorManager.primaryLight,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r), // responsive radius
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor ?? Colors.white,
                size: (fontSize + 2).sp, // responsive icon size
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: boldStyle(fontSize: 16, color: Colors.white)
            ),
          ],
        ),
      ),
    );
  }
}
