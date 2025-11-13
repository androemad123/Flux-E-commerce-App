import 'package:depi_graduation/app/BLoC/CartBLoC/cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/CartBLoC/cart_event.dart';
import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackBLoC.dart';
import 'package:depi_graduation/app/BLoC/InvitaionBLoC/invitation_bloc.dart';
import 'package:depi_graduation/app/BLoC/OrderBLoC/orders_bloc.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_bloc.dart';
import 'package:depi_graduation/core/di/setup_service_locator.dart';
import 'package:depi_graduation/firebase_options.dart';
import 'package:depi_graduation/routing/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'app/flux_app.dart';
import 'app/provider/language_provider.dart';
import 'app/provider/theme_provider.dart';
import 'data/repositories/order_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DefaultCacheManager().emptyCache(); // clear cache on app start

  SetupSeviceLocator.init();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize LanguageProvider and load saved locale
  final languageProvider = LanguageProvider();
  await languageProvider.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: languageProvider),
      ],
      child: RepositoryProvider(
        create: (_) => OrderRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductBLoC>(
              create: (_) => ProductBLoC()..add(LoadAllProducts()),
            ),
            BlocProvider<CartBloc>(
              create: (_) => CartBloc()..add(const CartStarted()),
            ),
            BlocProvider<OrdersBloc>(
              create: (context) => OrdersBloc(
                orderRepository: context.read<OrderRepository>(),
              ),
            ),
            BlocProvider<FeedbackBLoC>(
              create: (_) => FeedbackBLoC(),
            ),
            BlocProvider<SharedCartBloc>(
              create: (_) => SharedCartBloc(),
            ),
            BlocProvider<InvitationsBloc>(
              create: (_) => InvitationsBloc(),
            ),

          ],
          child: FluxApp(appRouter: AppRouter()),
        ),
      ),
    ),
  );
}
