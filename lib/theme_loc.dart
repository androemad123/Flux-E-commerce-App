import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:depi_graduation/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../../app/provider/language_provider.dart';
import '../../app/provider/theme_provider.dart';
import '../../generated/l10n.dart';


class ThemeLoc extends StatefulWidget {
  const ThemeLoc({super.key});

  @override
  State<ThemeLoc> createState() => _ThemeLoc();
}

class _ThemeLoc extends State<ThemeLoc> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextButton(
             width: 200.w,
            text: themeProvider.isDarkMode
                ? "Switch to Light and en"
                : "Switch to Dark and ar",
            onPressed: () {
              themeProvider.toggleTheme();
              languageProvider.setLocale(const Locale('en'));
            },
          ),
          SizedBox(height: 20.h,),
          AppTextButton(
            width: 200.w,
            text: themeProvider.isDarkMode
                ? "Switch to Light"
                : "Switch to Dark ",
            onPressed: () {
              themeProvider.toggleTheme();
              languageProvider.setLocale(const Locale('ar'));

            },
          ),
          SizedBox(height: 20.h,),
          Container(width: 300.w,height: 300.h,
          color: Theme.of(context).primaryColor,),
          SizedBox(height: 200.h),
           AppTextField(
            hintText: S.of(context).email,
            icon: Icons.email,
          ),
          Text(
            S.of(context).title,
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
