import 'package:depi_graduation/app/provider/language_provider.dart';
import 'package:depi_graduation/app/provider/theme_provider.dart';
import 'package:depi_graduation/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../presentation/resources/theme_manager.dart';
import '../routing/routes.dart';

class FluxApp extends StatefulWidget {
  // private constructor for singleton
  FluxApp._internal({required this.appRouter});

  static FluxApp? _instance;

  final AppRouter appRouter;

  factory FluxApp({required AppRouter appRouter}) {
    // create only one instance
    //singleton DP
    _instance ??= FluxApp._internal(appRouter: appRouter);
    return _instance!;
  }

  @override
  State<FluxApp> createState() => _FluxAppState();
}

class _FluxAppState extends State<FluxApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme, // Light theme
          darkTheme: AppTheme.darkTheme, // Dark theme
          themeMode: themeProvider.themeMode,
          locale: languageProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,

          initialRoute: Routes.productDetailsRoute,

          onGenerateRoute: widget.appRouter.generateRoute,
        );
      },
    );
  }
}
