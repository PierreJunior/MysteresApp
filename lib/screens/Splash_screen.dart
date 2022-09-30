import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:mysteres/services/checkDay.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String todaysDate = '';
  @override
  void initState() async {
    super.initState();
    getDate();
  }

  void getDate() {
    var getday = CheckingDate().getDate(todaysDate);

    if (!mounted) return;
    Navigator
      ),
    );
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
          [Colors.indigo.shade200, Colors.indigoAccent],
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
