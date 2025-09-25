import 'package:depi_graduation/cubit/auth/auth_cubit.dart';
import 'package:depi_graduation/cubit/auth/auth_state.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:depi_graduation/presentation/widgets/app_text_field.dart';
import 'package:depi_graduation/routing/app_router.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:depi_graduation/core/methods/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isLoginSuccess == true) {
            Navigator.pushNamed(context, Routes.homeRoute);
          } else if (state.isLoginError == true) {
            final message =
                state.loginErrorMessage ?? 'Login failed. Please try again.';
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
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validateEmail,
                  ),
                  SizedBox(height: 12.h),
                  AppTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",
                        style: regularStyle(
                            fontSize: 13.sp,
                            color: ColorManager.lightGrayLight)),
                  ),
                  SizedBox(height: 20.h),
                                     AppTextButton(
                     textColor: ColorManager.primaryLight,
                     text: 'Login',
                     isLoading: state.isLoginLoading ?? false,
                     onPressed: state.isLoginLoading == true ? null : () {
                       if (_formKey.currentState!.validate()) {
                         context.read<AuthCubit>().login(
                               email: _emailController.text,
                               password: _passwordController.text,
                             );
                       }
                     },
                   ),
                  SizedBox(height: 20.h),
                  // CircleAvatar(
                  //   backgroundColor: AppColors.formColor,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       SetupSeviceLocator.sl<AuthCubit>().signInWithGoogle();
                  //     },
                  //     icon: Image.asset(
                  //       AppAssets.googleLogo,
                  //       width: context.screenWidth * 0.07,
                  //       height: context.screenHeight * 0.07,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: context.screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: regularStyle(
                            fontSize: 13.sp,
                            color: ColorManager.lightGrayLight),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signUpRoute);
                        },
                        child: Text(
                          "Sign Up",
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
