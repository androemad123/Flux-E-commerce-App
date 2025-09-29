import 'package:depi_graduation/presentation/auth/login/widgets/login_form.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Log into your account",
              style:
                  boldStyle(fontSize: 40.sp, color: ColorManager.primaryLight)),
          SizedBox(height: 12.h),
          LoginForm()
        ],
      ),
    );
  }
}
