import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
              child: Image.asset(
                'assets/images/1stOnboardingPic.jpg',
                fit: BoxFit.cover,
              ),
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
            'Discover Something New',
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        SizedBox(height: 20.h),
        Center(
          child: Text(
            'Special new arrivals just for you',
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
