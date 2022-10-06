import 'package:flutter/material.dart';
import 'package:mysteres/drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          child: Column(
            children: [
              DrawerItem(
                name: 'Mysteres Lumineux',
                icon: Icons.light_mode,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 10),
              DrawerItem(
                name: 'Mysteres Douloureux',
                icon: Icons.people,
                onPressed: () => onItemPressed(context, index: 1),
              ),
              const SizedBox(height: 10),
              DrawerItem(
                name: 'Mysteres Glorieux',
                icon: Icons.thumb_up_sharp,
                onPressed: () => onItemPressed(context, index: 2),
              ),
              const SizedBox(height: 10),
              DrawerItem(
                name: 'How to Pray',
                icon: Icons.front_hand_sharp,
                onPressed: () => onItemPressed(context, index: 3),
              ),
              const SizedBox(height: 10),
              DrawerItem(
                name: 'Settings',
                icon: Icons.settings,
                onPressed: () => onItemPressed(context, index: 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
  }
}
