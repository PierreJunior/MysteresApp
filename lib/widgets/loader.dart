import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';

class Loader extends StatelessWidget {
  const Loader(
      {Key? key,
      this.strokeWidth = 10,
      this.backgroundColor = ColorPalette.primaryDark,
      this.color = ColorPalette.secondaryDark})
      : super(key: key);

  final double strokeWidth;
  final Color backgroundColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
      backgroundColor: backgroundColor,
      strokeWidth: strokeWidth,
    );
  }
}
