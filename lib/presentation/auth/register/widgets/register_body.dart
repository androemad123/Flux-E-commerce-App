import 'package:depi_graduation/presentation/auth/register/widgets/register_form.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     const ThemeToggleButton(),
          //   ],
          // ),
          Text("Create your account",
              style:
                  boldStyle(fontSize: 40.sp, color: ColorManager.primaryLight)),

          SizedBox(height: 12.h),

          RegisterForm(),
        ],
      ),
    );
  }
}
