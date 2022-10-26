import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {super.key, required this.colour, required this.cardChild, this.shadows});

  final Color colour;
  final Widget cardChild;
  final List<BoxShadow>? shadows;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: Adaptive.w(90),
        height: Adaptive.h(60),
        margin: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(30),
            boxShadow: shadows),
        child: cardChild,
      ),
    );
  }
}
