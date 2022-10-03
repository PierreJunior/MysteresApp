import 'package:flutter/material.dart';

const kMysteresTitle = TextStyle(fontSize: 40, color: Colors.white70);

const kMysteresBody = TextStyle(fontSize: 20, color: Colors.white70);

const kMysteresSubTitle = TextStyle(fontSize: 30, color: Colors.white70);

const kMysteresDouloureux = TextStyle(fontSize: 30, color: Colors.white70);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  icon: Icon(
    Icons.date_range_sharp,
    color: Color(0xFFC5CAE9),
  ),
  hintText: 'Enter a day',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  ),
);

const kButtonTextStyle = TextStyle(
  fontSize: 60.0,
  fontFamily: 'Square Peg',
  color: Color(0xFFC5CAE9),
);
