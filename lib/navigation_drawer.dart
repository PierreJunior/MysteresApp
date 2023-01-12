import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/drawer_item.dart';
import 'package:mysteres/l10n/locale_keys.g.dart';
import 'package:mysteres/screens/landing_screen.dart';
import 'package:mysteres/screens/language_settings_screen.dart';

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
                name: LocaleKeys.pageNameHome.tr(),
                icon: Icons.home,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 10),
              DrawerItem(
                name: LocaleKeys.pageNameSettings.tr(),
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

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LandingScreen(),
          ),
        );
        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LanguageSettings()));
        break;
    }
  }
}
