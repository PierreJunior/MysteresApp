import 'package:flutter/material.dart';
import 'package:mysteres/components/font.dart';
import 'package:mysteres/navigation_Drawer.dart';
import 'package:mysteres/constants.dart';

class MysteresJoyeux extends StatefulWidget {
  static const String id = "mysteresJoyeux";

  const MysteresJoyeux({Key? key}) : super(key: key);

  @override
  State<MysteresJoyeux> createState() => _MysteresJoyeuxState();
}

class _MysteresJoyeuxState extends State<MysteresJoyeux> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white10,
        ),
        backgroundColor: Colors.blue.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Mystère Joyeux',
                    style: Font.heading1,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'L’annonciation',
                  style: Font.heading3,
                ),
                SizedBox(height: 40),
                SingleChildScrollView(
                  child: Text(
                    "Le sixième mois, l'ange Gabriel fut envoyé par Dieu dans une ville de Galilée, appelée Nazareth, à une vierge,accordée en mariage à un homme de la maison de David, appelé Joseph; et le nom de la Vierge était Marie.» (Lc 1,26- 27)",
                    style: Font.paragraph,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
