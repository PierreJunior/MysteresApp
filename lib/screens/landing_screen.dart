import 'package:flutter/material.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/services/rosary_config_service.dart';

class LandingScreen extends StatefulWidget {
  static const String id = "LandingPage";

  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late RosaryConfigService _rosaryConfigService;
  String _selectedDay = "";
  String _selectedMystere = "";

  _LandingScreenState() {
    _rosaryConfigService = RosaryConfigService();
  }

  @override
  void initState() {
    super.initState();
    initDay();
    initMystere();
  }

  void initDay() {
    setState(() {
      _selectedDay = _rosaryConfigService.getCurrentDay();
    });
  }

  void initMystere() {
    setState(() {
      _selectedMystere = _rosaryConfigService.getMystere(_selectedDay);
    });
  }

  void onResetPressed() {
    initDay();
    initMystere();
  }

  void onDayChanged(String day) {
    setState(() {
      _selectedDay = day;
      _selectedMystere = _rosaryConfigService.getMystere(_selectedDay);
    });
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
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedDay,
                    items: _rosaryConfigService.getDays().map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      onDayChanged(val.toString());
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedMystere,
                    items:
                        _rosaryConfigService.getMysteres().map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: null,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () => onResetPressed(),
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
