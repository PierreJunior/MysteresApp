import 'package:flutter/material.dart';
import '../constants.dart';

class MysteresDouloureux extends StatefulWidget {
  static const String id = "mysteresDouloureux";

  const MysteresDouloureux({Key? key}) : super(key: key);

  @override
  State<MysteresDouloureux> createState() => _MysteresDouloureuxState();
}

class _MysteresDouloureuxState extends State<MysteresDouloureux> {
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
                  'Mystère Douloureux',
                  style: kMysteresDouloureux,
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
