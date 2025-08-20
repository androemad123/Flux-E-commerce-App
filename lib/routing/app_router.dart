import 'package:depi_graduation/presentation/home/base_home_screen.dart';
import 'package:depi_graduation/presentation/onboarding/welcome_screen.dart';
import 'package:depi_graduation/presentation/sign%20up/sign_up_screen.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/product details/product_details_screen.dart';

class AppRouter {
  AppRouter();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => BaseHomeScreen());
      case Routes.productDetailsRoute:
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen());
      case Routes.welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("this is undefined Route"),
        ),
      ),
    );
  }
}
