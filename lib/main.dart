import 'package:depi_graduation/core/di/setup_service_locator.dart';
import 'package:depi_graduation/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/flux_app.dart';
import 'app/provider/language_provider.dart';
import 'app/provider/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SetupSeviceLocator.init();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: FluxApp(appRouter: AppRouter()),
    ),
  );
}
