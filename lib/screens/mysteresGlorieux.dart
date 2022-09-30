import 'package:flutter/material.dart';

import '../constants.dart';

class MysteresGlorieux extends StatelessWidget {
  static const String id = "mysteresGlorieux";
  const MysteresGlorieux({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
      ),
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Mystère Glorieux',
                  style: kMysteresTitle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'SubTitle',
                style: kMysteresSubTitle,
              ),
              SizedBox(height: 40),
              SingleChildScrollView(
                child: Text(
                  'MysteresBody',
                  style: kMysteresBody,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
