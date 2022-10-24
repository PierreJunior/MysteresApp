import 'package:flutter/material.dart';
import '../components/color_palette.dart';

class Ads extends StatelessWidget {
  const Ads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: ColorPalette.primaryDark,
      child: const Center(
          child: Text(
        'Ads go here',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
