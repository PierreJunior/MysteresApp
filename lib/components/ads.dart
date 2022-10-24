import 'package:flutter/material.dart';

import 'color_palette.dart';

class Ads extends StatelessWidget {
  const Ads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: ColorPalette.primaryDark,
      child: const Center(
          child: Text(
        'Ads will go here',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
