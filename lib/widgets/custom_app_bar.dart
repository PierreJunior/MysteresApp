import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mysteres/l10n/locale_keys.g.dart';

import '../components/color_palette.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text(
        LocaleKeys.appName.tr(),
        style: const TextStyle(color: ColorPalette.primary),
      ),
      backgroundColor: ColorPalette.primaryDark,
    );
  }
}
