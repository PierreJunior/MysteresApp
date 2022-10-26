import 'package:flutter/material.dart';
import '../components/font.dart';

class ContainerContent extends StatelessWidget {
  const ContainerContent({super.key, required this.prayerBody});

  final String prayerBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prayerBody,
          style: Font.paragraph,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}
