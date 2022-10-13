import 'package:flutter/material.dart';
import 'package:mysteres/constants.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/screens/pray_screen.dart';
import 'package:mysteres/services/rosary_config_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mysteres/components/rounded_button.dart';

List<String> lang = <String>['English', 'French', 'Portuguese'];

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
  String _selectedLanguage = lang.first;

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
          title: const Text('ROSARY'),
          backgroundColor: kTopBarColor,
        ),
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Configure your Prayer settings',
                    style: kMysteresTitle,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 6)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.language),
                              SizedBox(width: 5),
                              Text(
                                'Select a Language',
                                style: kContainerText,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              value: _selectedLanguage,
                              buttonHeight: 50,
                              buttonWidth:
                                  MediaQuery.of(context).size.width * 2,
                              dropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.grey.shade200,
                                  boxShadow: const [
                                    BoxShadow(color: Colors.transparent)
                                  ]),
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.transparent,
                                  boxShadow: const [
                                    BoxShadow(color: Colors.transparent)
                                  ]),
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownPadding: null,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              buttonElevation: 8,
                              items: lang.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: kContainerText,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedLanguage = value as String;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: const [
                              Icon(Icons.calendar_month_outlined),
                              SizedBox(width: 5),
                              Text(
                                'Select a Day',
                                style: kContainerText,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              buttonDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.transparent,
                                  boxShadow: const [
                                    BoxShadow(color: Colors.transparent)
                                  ]),
                              isExpanded: true,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              value: _selectedDay,
                              buttonHeight: 50,
                              buttonWidth:
                                  MediaQuery.of(context).size.width * 2,
                              dropdownDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.grey.shade200,
                                  boxShadow: const [
                                    BoxShadow(color: Colors.transparent)
                                  ]),
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownPadding: null,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              buttonElevation: 8,
                              items: _rosaryConfigService
                                  .getDays()
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: kContainerText,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                onDayChanged(val.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedButton(
                          colour: kButtonColor1,
                          pressed: () => onResetPressed(),
                          title: 'RESET'),
                      const SizedBox(
                        width: 20,
                      ),
                      RoundedButton(
                          colour: kButtonColor2,
                          pressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrayScreen(
                                          selectedDay: _selectedDay,
                                        )));
                          },
                          title: 'Pray'),
                    ],
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
