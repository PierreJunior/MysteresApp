import 'package:flutter/material.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/screens/day_screen.dart';
import 'package:mysteres/services/checkDay.dart';
import 'package:mysteres/globalVariable.dart';

const List<String> daysofWeek = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Sunday'
];

class LandingScreen extends StatefulWidget {
  static const String id = "LandingPage";

  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  var todayMysteres2 = GlobalValue.checking;
  CheckingDate dateAndMysteres = CheckingDate();
  late String todayMysteres = '';
  late String todaysDate = '';
  late String today = '';
  late String mystereCheck = '';
  late var updating = '';
  late String dropdownValue = daysofWeek.first;
  void getDate() {
    setState(() {
      today = dateAndMysteres.getDate(dropdownValue);
      dropdownValue = today;
    });
  }

  void getMysteres() {
    setState(() {
      todayMysteres = dateAndMysteres.getMysteres(mystereCheck);
    });
  }

  @override
  void initState() {
    super.initState();
    getDate();
    getMysteres();
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
                          final result =
                              await Navigator.pushNamed(context, DayScreen.id);

                          setState(() {
                            today = result as String;
                            updating = GlobalValue.checking;
                            todayMysteres = updating;
                          });
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
                  StreamBuilder<Object>(
                      stream: null,
                      builder: (context, snapshot) {
                        return Text(
                          'Mystere: $todayMysteres',
                          style: kMysteresSubTitle,
                        );
                      }),
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
