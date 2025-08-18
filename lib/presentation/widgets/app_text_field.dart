import 'package:flutter/material.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/styles_manager.dart';
import '../resources/value_manager.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: regularStyle(
          fontSize: AppSize.s16, // ✅ from ValuesManager
          color: theme.primaryColor,
        ),
        prefixIcon: icon != null
            ? Icon(icon, color: theme.iconTheme.color)
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.lightGrayDark,
            width: AppSize.s1, // ✅ from ValuesManager
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primaryLight,
            width: AppSize.s2, // ✅ from ValuesManager
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: AppSize.s1, // ✅ consistent
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: AppSize.s2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: AppPadding.p10, // ✅ from ValuesManager
          horizontal: AppPadding.p8,
        ),
      ),
    );
  }
}
