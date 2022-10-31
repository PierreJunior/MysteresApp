import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Font {
  static TextStyle heading1 = TextStyle(
    fontSize: 23.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading3 = TextStyle(fontSize: 21.sp, color: Colors.white70);

  static TextStyle paragraph = TextStyle(
      fontSize: 20.sp,
      color: Colors.white70,
      height: Device.orientation == Orientation.portrait
          ? Device.screenType == ScreenType.tablet
              ? 0.2.h
              : 0.3.h
          : Device.screenType == ScreenType.tablet
              ? 0.4.h
              : 0.5.h);

  static TextStyle containerText = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black);
}
