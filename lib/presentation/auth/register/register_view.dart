import 'package:depi_graduation/presentation/auth/register/widgets/register_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Center(child: RegisterBody()),
        ),
      ),
    );
  }
}