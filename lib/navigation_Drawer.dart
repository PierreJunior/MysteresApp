import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/drawer_item.dart';
import 'package:mysteres/screens/landing_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: ColorPalette.primaryDark,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children: [
              DrawerItem(
                  name: 'Home',
                  icon: Icons.home,
                  onPressed: () {
                    onItemPressed(context, index: 0);
                  }),
              const SizedBox(height: 10),
              DrawerItem(
                name: 'Settings',
                icon: Icons.settings,
                onPressed: () => onItemPressed(context, index: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    void showNotification(String message, int duration, Color color) {
      Flushbar(
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        backgroundColor: color,
        message: message,
        duration: Duration(seconds: duration),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingScreen(),
          ),
        );
        if (LandingScreen.checkPage == true) {
          showNotification(
              "You ended your Rosary early", 5, ColorPalette.primaryWarning);
        }
        break;
    }
  }
}
