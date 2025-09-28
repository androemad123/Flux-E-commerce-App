import 'package:depi_graduation/cubit/auth/auth_cubit.dart';
import 'package:depi_graduation/cubit/auth/auth_state.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:depi_graduation/presentation/widgets/app_text_field.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:depi_graduation/core/methods/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    // _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isRegisterSuccess == true) {
            Navigator.pushNamed(context, Routes.loginRoute);
          } else if (state.isRegisterError == true) {
            final message = state.registerErrorMessage ??
                'Registration failed. Please try again.';
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  backgroundColor: ColorManager.primaryLight,
                  content: Text(message,
                      style:
                          regularStyle(fontSize: 13.sp, color: Colors.white))));
          }
        },
        builder: (context, state) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Column(
                children: [
                  AppTextField(
                    controller: _nameController,
                    hintText: 'User Name',
                    keyboardType: TextInputType.name,
                    validator: AppValidators.validateName,
                  ),
                  SizedBox(height: 12.h),
                  AppTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                  ),
                  SizedBox(height: 12.h,),
                 
                  SizedBox(height: 12.h),
                  AppTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                  ),
                  SizedBox(height: 12.h),
                  AppTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: _validateConfirmPassword,
                  ),
                  SizedBox(height: 20.h),
                  AppTextButton(
                    // textColor: AppColors.onTertiary,
                    // fontSize: 16,
                    text: 'Register',
                    isLoading: state.isRegisterLoading ?? false,
                    onPressed: state.isRegisterLoading == true ? null : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                              name: _nameController.text,
                              email: _emailController.text,
                              // phone: _phoneController.text,
                              password: _passwordController.text,
                            );
                      }
                    },
                  ),

                  SizedBox(height: 20.h),

                  // SizedBox(height: context.screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: regularStyle(
                            fontSize: 13.sp,
                            color: ColorManager.lightGrayLight),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login",
                          style: boldStyle(
                                  fontSize: 14.sp,
                                  color: ColorManager.primaryLight)
                              .copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
