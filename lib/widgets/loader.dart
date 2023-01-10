import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(ColorPalette.secondaryDark),
      backgroundColor: ColorPalette.primaryDark,
      strokeWidth: 10,
    );
  }
}
