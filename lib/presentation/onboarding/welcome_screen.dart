import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcomePic.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity.w,
            color: Colors.black.withOpacity(0.5), // Black overlay
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 420.h), // Adjust height as needed
              Center(
                child: Text(
                  'Welcome to Our App',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'The home for a fashionista',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h), // Space between text and button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.9),
                  side: const BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 10.h,
                  ),
                ),
                onPressed: () {
                  // Navigate to the next screen or perform an action
                  Navigator.pushNamed(
                      context, '/onboardingRoute'); // Replace with your route
                },
                child:
                    Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
