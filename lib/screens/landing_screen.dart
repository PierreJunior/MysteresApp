import 'package:flutter/material.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/screens/day_screen.dart';
import 'package:mysteres/services/checkDay.dart';

class LandingScreen extends StatefulWidget {
  static const String id = "LandingPage";

  const LandingScreen({
    Key? key,
    this.updating,
  }) : super(key: key);

  final dynamic updating;
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  CheckingDate dateAndMysteres = CheckingDate();
  late String todayMysteres = '';
  late String todaysDate = '';
  late String today = '';
  late String mystereCheck = '';
  void getDate(CheckingDate updateUI) {
    setState(() {
      today = dateAndMysteres.getDate(todaysDate);
    });
  }

  void getMysteres(CheckingDate updateUI) {
    setState(() {
      todayMysteres = dateAndMysteres.getMysteres(mystereCheck);
    });
  }

  @override
  void initState() {
    super.initState();
    getDate(widget.updating);
    getMysteres(widget.updating);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white10,
        ),
        backgroundColor: Colors.indigoAccent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          var updateUI = await CheckingDate();
                          getDate(updateUI);
                          getMysteres(updateUI);
                        },
                        child: const Icon(
                          Icons.update_sharp,
                          size: 50,
                          color: Colors.white70,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, DayScreen.id);
                        },
                        child: const Icon(
                          Icons.calendar_today,
                          size: 50,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    today,
                    style: kMysteresTitle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Mystere: $todayMysteres',
                    style: kMysteresSubTitle,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {},
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 25, color: Colors.white70),
                      )),
                  const SizedBox(height: 20),
                  FloatingActionButton.large(
                    onPressed: () {},
                    child: const Text(
                      'START',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
