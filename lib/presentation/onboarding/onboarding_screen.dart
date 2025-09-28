import 'package:depi_graduation/presentation/onboarding/subScreens/final_screen.dart';
import 'package:depi_graduation/presentation/onboarding/subScreens/first_screen.dart';
import 'package:depi_graduation/presentation/onboarding/subScreens/second_screen.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1.0, // Adjust this to change the width of each page
  );
  int _currentPage = 0;

  void _goToNextPage() {
    if (_pageController.hasClients) {
      final nextPage = _pageController.page!.toInt() + 1;
      if (nextPage < 3) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height * 1),
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return PageView(
                      onPageChanged: _onPageChanged,
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const FirstScreen(),
                        const SecondScreen(),
                        const FinalScreen(),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: (MediaQuery.of(context).size.height * 0.18),
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      width: _currentPage == index ? 16.w : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                left: (MediaQuery.of(context).size.width / 2) -
                    65, // Center the button
                child: OutlinedButton(
                  onPressed: _goToNextPage,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.9),
                    side: const BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the next screen or perform an action
                      Navigator.pushNamed(context,
                          "/loginRoute"); // Replace with your route
                    },
                    child: Text(
                      'Shopping Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
