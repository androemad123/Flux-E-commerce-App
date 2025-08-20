import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _upperContainer(),
          Positioned(
              bottom: 0.h, left: 0.w, right: 0.w, child: _bottomContainer()),
          Positioned(
            left: (width / 2) - 105.w,
            bottom: height * 0.25.h,
            child: Container(
              height: 400.h,
              width: 225.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/images/3rdOnboardingPic.jpg',
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _upperContainer() {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Text(
            'Explore Your True Style',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Text(
            'Relax and let us bring the style to you',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _bottomContainer() {
  return Container(
    height: 300.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color.fromRGBO(70, 68, 71, 1),
      borderRadius: BorderRadius.circular(1),
    ),
  );
}
