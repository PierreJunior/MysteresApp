import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mysteres/ads_state.dart';
import 'package:mysteres/env.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:provider/provider.dart';
import 'package:mysteres/screens/splash_screen.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:applovin_max/applovin_max.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final initFuture = MobileAds.instance.initialize();
  Map? sdkConfiguration = await AppLovinMAX.initialize(Env.appLovinSDK);
  AppLovinMAX.setIsAgeRestrictedUser(false);
  AppLovinMAX.setDoNotSell(false);
  AppLovinMAX.setHasUserConsent(true);
  final adState = AdState(initFuture);
  await SentryFlutter.init((options) {
    options.dsn = Env.sentryDSN;
    options.tracesSampleRate = double.parse(Env.sentryTraceSampleRate);
    options.attachScreenshot =
        Env.sentryAttachScreenshot.toLowerCase() == 'true';
    options.addIntegration(LoggingIntegration());
  }, appRunner: () {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      LoggingService.message(details.exceptionAsString(),
          level: LoggingLevel.error, transction: "FlutterError");
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      LoggingService().exception(error, stack);
      return true;
    };
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
          Locale('pt'),
          Locale('sw')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: Provider.value(
          value: adState,
          builder: (context, child) => const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
