import 'package:flutter/material.dart';
import 'package:mysteres/global_variable.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/screens/language_settings_screen.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            FirstWave(),
          ],
        ),
      ),
    );
  }
}

class FirstWave extends StatelessWidget {
  const FirstWave({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        durations: [35000],
        heightPercentages: [0.2],
        gradients: [
          [Colors.indigo.shade200, Colors.blue],
          // [Colors.indigoAccent.shade700, Colors.indigo.shade200],
        ],
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      size: Size(MediaQuery.of(context).size.width * 1,
          MediaQuery.of(context).size.height * 0.8),
      waveAmplitude: 50,
      waveFrequency: 2,
      isLoop: true,
    );
  }
}
