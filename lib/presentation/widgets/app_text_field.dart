import 'package:flutter/material.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/styles_manager.dart';
import '../resources/value_manager.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final Widget? suffix;

  const AppTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.suffix,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: theme.textTheme.bodyLarge,
      // style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: regularStyle(
          fontSize: AppSize.s16, // ✅ from ValuesManager
          color: theme.primaryColor,
        ),
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: theme.iconTheme.color)
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: theme.iconTheme.color,
                ),
              )
            : widget.suffix,
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
