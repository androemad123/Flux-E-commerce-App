import 'package:depi_graduation/app/BLoC/CartBLoC/cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_event.dart';
import 'package:depi_graduation/app_init.dart';
import 'package:depi_graduation/core/di/setup_service_locator.dart';
import 'package:depi_graduation/cubit/auth/auth_cubit.dart';
import 'package:depi_graduation/data/repositories/order_repository.dart';
import 'package:depi_graduation/presentation/Cart/ProductsCart.dart';
import 'package:depi_graduation/presentation/auth/login/login_view.dart';
import 'package:depi_graduation/presentation/auth/register/register_view.dart';
import 'package:depi_graduation/presentation/check%20out/check_out_screen.dart';
import 'package:depi_graduation/presentation/home/base_home_screen.dart';
import 'package:depi_graduation/presentation/my%20orders/my_orders_screen.dart';
import 'package:depi_graduation/presentation/onboarding/welcome_screen.dart';
import 'package:depi_graduation/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/product details/product_details_screen.dart';

class AppRouter {
  AppRouter();
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: SetupSeviceLocator.sl<AuthCubit>(), child: LoginView()));
      case Routes.signUpRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: SetupSeviceLocator.sl<AuthCubit>(),
                child: const RegisterView()));
      case Routes.appInit:
        return MaterialPageRoute(builder: (_) => AppInit());
      case Routes.myOrdersScreen:
        return MaterialPageRoute(builder: (_) => MyOrdersScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => BaseHomeScreen());
      case Routes.productDetailsRoute:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productId: productId),
        );
      case Routes.cartRoute:
        return MaterialPageRoute(
          builder: (_) => const ProductsCartScreen(),
        );
      case Routes.checkoutRoute:
        return MaterialPageRoute(
          builder: (context) {
            final cartState = context.read<CartBloc>().state;
            return BlocProvider(
              create: (ctx) => CheckoutBloc(
                orderRepository: ctx.read<OrderRepository>(),
              )..add(
                  CheckoutStarted(
                    cartItems: cartState.items,
                  ),
                ),
              child: const CheckOutScreen(),
            );
          },
        );
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
