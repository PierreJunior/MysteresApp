import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/widgets/custom_app_bar.dart';
import 'package:mysteres/widgets/rounded_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Error extends StatelessWidget {
  const Error({
    Key? key,
    required this.message,
    this.emoji = Emojis.warning,
  }) : super(key: key);

  final String message;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: ColorPalette.primary,
        body: SafeArea(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: TextStyle(fontSize: 30.sp)),
            Text(
              message,
              style: Font.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            RoundedButton(
                colour: ColorPalette.primaryDark,
                pressed: () {
                  Navigator.pop(context);
                },
                title: 'Home')
          ],
        ))),
      ),
    );
  }
}
