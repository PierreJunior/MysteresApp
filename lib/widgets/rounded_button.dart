import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    Key? key,
    required this.colour,
    required this.pressed,
    required this.title,
  }) : super(key: key);

  final double roundButtonHeight =
      Device.screenType == ScreenType.tablet ? 80 : 42.0;

  final Color? colour;
  final VoidCallback pressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(widgetBorderRadius),
        child: MaterialButton(
          onPressed: pressed,
          minWidth: 150.0,
          height: roundButtonHeight,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
