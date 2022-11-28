import 'package:flutter/material.dart';
import 'package:mysteres/global_variable.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/screens/language_settings_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/color_palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    landing();
  }

  void landing() async {
    final prefs = await SharedPreferences.getInstance();
    int defaultLangSet =
        prefs.getInt(GlobalValue.sharedPreferenceLanguageSetKey) ?? 0;
    if (!mounted) return;
    defaultLangSet == 0
        ? Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LanguageSettings()))
        : Future.delayed(const Duration(seconds: 3)).then((value) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LandingScreen()));
          });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: ColorPalette.primaryLight,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/AppLogo.png'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
