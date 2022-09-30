import 'package:flutter/material.dart';
import 'package:mysteres/screens/HomeScreen.dart';
import 'package:mysteres/screens/day_screen.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/screens/mystereLumineux.dart';
import 'package:mysteres/screens/mysteresDouloureux.dart';
import 'package:mysteres/screens/mysteresGlorieux.dart';
import 'screens/Splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LandingScreen.id: (context) => const LandingScreen(),
        DayScreen.id: (context) => const DayScreen(),
        MysteresJoyeux.id: (context) => const MysteresJoyeux(),
        MystereLumineux.id: (context) => const MystereLumineux(),
        MysteresDouloureux.id: (context) => const MysteresDouloureux(),
        MysteresGlorieux.id: (context) => const MysteresGlorieux(),
      },
    );
  }
}
