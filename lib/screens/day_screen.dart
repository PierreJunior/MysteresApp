import 'dart:ffi';
import 'package:mysteres/constants.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/services/checkDay.dart';
import '../navigation_Drawer.dart';

const List<String> daysofWeek = <String>[
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Sunday'
];

class DayScreen extends StatefulWidget {
  static const String id = 'dayscreen';
  const DayScreen({Key? key}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  TextEditingController textFieldController = TextEditingController();
  late String todayrewrite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white10,
      ),
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 50,
                  color: Colors.white70,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: textFieldController,
                onChanged: (value) {
                  todayrewrite = value;
                },
                decoration: kTextFieldInputDecoration,
              ),
            ),
            TextButton(
              onPressed: () {
                String textToSendBack = textFieldController.text;
                String check =
                    CheckingDate().getMysteres(textToSendBack) as String;
                Navigator.pop(context, textToSendBack);
              },
              child: const Text(
                'Update Day',
                style: kButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
