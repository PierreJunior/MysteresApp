import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:provider/provider.dart';
import 'package:mysteres/screens/Splash_screen.dart';
import 'package:mysteres/screens/landing_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  print('1');
  final adState = AdState(initFuture);
  print('2');
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => const MyApp(),
    ),
  );
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
      },
    );
  }
}
