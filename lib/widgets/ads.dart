import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Ads extends StatelessWidget {
  const Ads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adaptive.h(10),
      color: ColorPalette.primaryDark,
      child: const Center(
        child: Text(
          'Ads go here',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
