import 'package:depi_graduation/app/flux_app.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../../app/provider/language_provider.dart';
import '../../app/provider/theme_provider.dart';
import '../../generated/l10n.dart';
import '../widgets/app_text_button.dart';
import '../widgets/app_text_field.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size(300, 300), child:Container(height: 100,)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextButton(
               width: 200,
              text: themeProvider.isDarkMode
                  ? "Switch to Light and en"
                  : "Switch to Dark and ar",
              onPressed: () {
                themeProvider.toggleTheme();
                languageProvider.setLocale(const Locale('en'));
              },
            ),
            SizedBox(height: 20,),

            AppTextButton(text: "text", onPressed: (){},width: 300,),
            SizedBox(height: 20.h,),
            Container(width: 300.w,height: 300.h,
            color: Theme.of(context).colorScheme.secondary,),
            const SizedBox(height: 200),
             AppTextField(
              hintText: S.of(context).email,
              icon: Icons.email,
            ),
            AppTextField(
              hintText: S.of(context).email,
            ),
            Text(
              S.of(context).email,
              style:  TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
