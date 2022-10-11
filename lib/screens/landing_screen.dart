import 'package:flutter/material.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/screens/pray_screen.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
          backgroundColor: Colors.cyan,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      value: _selectedDay,
                      buttonHeight: 50,
                      buttonWidth: 160,
                      dropdownDecoration:
                          const BoxDecoration(color: Colors.cyan),
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.cyan,
                      ),
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownPadding: null,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      buttonElevation: 8,
                      items: _rosaryConfigService.getDays().map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        onDayChanged(val.toString());
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton2<String>(
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    value: _selectedMystere,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    dropdownDecoration: const BoxDecoration(color: Colors.cyan),
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.cyan,
                    ),
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownPadding: null,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    buttonElevation: 8,
                    items:
                        _rosaryConfigService.getMysteres().map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
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
                        style: TextStyle(fontSize: 25, color: Colors.grey),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 1),
                            blurRadius: 6)
                      ],
                      border: Border.all(
                          color: Colors.cyan,
                          width: 2,
                          style: BorderStyle.solid),
                    ),
                    child: FloatingActionButton.large(
                      foregroundColor: Colors.cyan,
                      backgroundColor: Colors.cyan,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrayScreen(
                                      selectedDay: _selectedDay,
                                    )));
                      },
                      child: const Text(
                        'Prier',
                        style: TextStyle(color: Colors.white),
                      ),
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
