import 'package:depi_graduation/app/BLoC/FeedbackBLoC/FeedbackBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductBLoC.dart';
import 'package:depi_graduation/app/BLoC/ProductBLoC/ProductEvent.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DefaultCacheManager().emptyCache(); // clear cache on app start

  SetupSeviceLocator.init();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBLoC>(
            create: (_) => ProductBLoC()..add(LoadAllProducts()),
          ),
          BlocProvider<FeedbackBLoC>(
            create: (_) => FeedbackBLoC()
          ),
        ],
        child: FluxApp(appRouter: AppRouter()),
      ),
    ),
  );
}
