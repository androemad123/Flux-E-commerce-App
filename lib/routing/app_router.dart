import 'package:depi_graduation/app/BLoC/CartBLoC/cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_event.dart';
import 'package:depi_graduation/app_init.dart';
import 'package:depi_graduation/core/di/setup_service_locator.dart';
import 'package:depi_graduation/cubit/auth/auth_cubit.dart';
import 'package:depi_graduation/data/models/cart_item.dart';
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
            // Check if arguments were passed (from shared cart)
            List<CartItem> items;
            String? sharedCartId;
            
            if (settings.arguments != null) {
              if (settings.arguments is Map) {
                final args = settings.arguments as Map<String, dynamic>;
                items = args['cartItems'] as List<CartItem>? ?? 
                        context.read<CartBloc>().state.items;
                sharedCartId = args['sharedCartId'] as String?;
              } else if (settings.arguments is List<CartItem>) {
                // Legacy support for direct list
                items = settings.arguments as List<CartItem>;
              } else {
                items = context.read<CartBloc>().state.items;
              }
            } else {
              // If no arguments, use items from CartBloc (regular cart)
              items = context.read<CartBloc>().state.items;
            }
            
            return BlocProvider(
              create: (ctx) => CheckoutBloc(
                orderRepository: ctx.read<OrderRepository>(),
                sharedCartId: sharedCartId, // Pass shared cart ID to CheckoutBloc
              )..add(
                  CheckoutStarted(
                    cartItems: items,
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
