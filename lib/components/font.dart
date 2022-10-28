import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Font {
  static TextStyle heading1 = TextStyle(
    fontSize: 23.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading3 = TextStyle(fontSize: 18.sp, color: Colors.white70);

  static TextStyle paragraph = TextStyle(
      fontSize: 18.sp,
      color: Colors.white70,
      height: 0.3.h,
      fontWeight: FontWeight.w700);

  static TextStyle containerText = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black);
}
