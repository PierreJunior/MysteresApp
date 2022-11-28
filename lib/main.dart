import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:mysteres/env.dart';
import 'package:provider/provider.dart';
import 'package:mysteres/screens/splash_screen.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  await SentryFlutter.init((options) {
    options.dsn = Env.sentryDSN;
    options.tracesSampleRate = double.parse(Env.sentryTraceSampleRate);
    options.addIntegration(LoggingIntegration());
  }, appRunner: () {
    runApp(
      Provider.value(
        value: adState,
        builder: (context, child) => const MyApp(),
      ),
    );
  });
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
        LandingScreen.id: (context) => LandingScreen(),
      },
    );
  }
}
