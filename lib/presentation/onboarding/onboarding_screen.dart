import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
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
      body: Column(
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
          AppTextButton(
            width: 200,
            text: themeProvider.isDarkMode
                ? "Switch to Light"
                : "Switch to Dark ",
            onPressed: () {
              themeProvider.toggleTheme();
              languageProvider.setLocale(const Locale('ar'));

            },
          ),
          SizedBox(height: 20,),
          Container(width: 300,height: 300,
          color: Theme.of(context).primaryColor,),
          const SizedBox(height: 200),
           AppTextField(
            hintText: S.of(context).email,
            icon: Icons.email,
          ),
          Text(
            S.of(context).title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
