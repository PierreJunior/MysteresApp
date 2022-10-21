import 'package:flutter/material.dart';

class Font {
  static const heading1 = TextStyle(
    fontSize: 30,
    fontFamily: "NotoSansJP Bold",
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static const heading3 = TextStyle(
    color: Colors.black,
    fontFamily: "NotoSansJP Bold",
    fontSize: 15,
  );

  static const paragraph = TextStyle(
      fontSize: 15, fontFamily: "NotoSansJP Bold", color: Colors.black);

  static const containerText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
}
