import 'package:flutter/material.dart';

class AppColor {
  static Color powderblue = const Color(0xFFEFF3F6);
  static Color blackwithopacity = const Color(0xFF000000).withOpacity(0.67);
  static Color black = const Color(0xFF000000);
  static Color red = Colors.red;
  static Color yellow = Colors.yellow;
  static Color backgroundColor = const Color(0xFFF1F1F1);
  static Color darkwhite = const Color(0XFFF4F3EF);
  static Color purple = const Color(0xFF5F27CD);
  static Color white = const Color(0XFFFFFFFF);
  static Color grey = const Color(0xFF94a3aa);
  static Color backgroundTable = const Color(0xFFD9D9D9).withOpacity(0.80);
  static Color greyWithOpcity = const Color(0xFFD9D9D9);
  static Color orange = const Color(0xFFE7823D);
  static Color brawn = const Color(0xFFad591f);
  static Color lightorange = const Color(0xffDFB9A3);
  static Color green = const Color(0xFF26955E);
  static Color lightgreen = const Color(0xFF7C8B74);
  static Color olive = const Color(0xFFAE9D01);
  static Color blue = Colors.blue;
  static Color darkblue = const Color(0xFF1D617A);
  static Color shadepurple = const Color(0xFF5F27CD);
  static Color iconsMenuActavit = const Color(0xFF5F27CD);
  static Color iconsMenu = const Color(0xFFA0A0A5);
  static Color azure = const Color(0xFF007AFF);
  static Color lightgray = const Color(0xFFF1F3F9);
  static Color gunmetal = const Color(0xFF1C1F26);
  static Color steelblue = const Color(0xFF96A0B6);
  static Color charcoal = const Color(0xFF40444C);
  static Color crimson = const Color(0xFFD64F4F);
  static Color shadowcharcoalblue = const Color(0x0C101828);

  ///Create a list of color shades
  static List<Color> generateShades(Color baseColor, {int numShades = 5}) {
    List<Color> shades = [];

    // Get the HSV values of the base color
    HSVColor hsvColor = HSVColor.fromColor(baseColor);
    double hue = hsvColor.hue;
    double saturation = hsvColor.saturation;
    double value = hsvColor.value;

    // Generate the shades
    for (int i = 0; i < numShades; i++) {
      double newValue =
          value - (value * 0.2 * i); // Decrease the value (brightness)
      shades.add(HSVColor.fromAHSV(1, hue, saturation, newValue).toColor());
    }

    return shades;
  }
}
