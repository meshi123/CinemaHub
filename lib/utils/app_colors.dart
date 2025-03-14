import 'package:cinema_hub/models/user_data.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color get colorSuccess => const Color(0XFF0BDA51);
  static Color get colorBtnDelete => const Color.fromRGBO(233, 78, 61, 1);
  static Color get colorEmail => Colors.blue;
  static Color get colorBlue => Colors.blue;
  static Color get colorDeepBlue => const Color(0XFF007bff);
  static Color get colorButtonSplash => const Color.fromARGB(93, 111, 214, 255);

  static Color get colorThemeBlackWhite =>
      userData.isDarkMode ? Colors.white : Colors.black;

  static Color get colorThemeBlackWhiteInverse =>
      userData.isDarkMode ? Colors.black : Colors.white;

  static Color get colorIcons =>
      userData.isDarkMode ? ThemeDark.colorIcons : ThemeLight.colorIcons;

  static Color get colorIconsUnselectedLightMode => Colors.grey.shade400;

  static Color get colorPrimaryDark => userData.isDarkMode
      ? ThemeDark.colorPrimaryDark
      : ThemeLight.colorPrimaryDark;

  static Color get colorPrimaryLight => userData.isDarkMode
      ? ThemeDark.colorPrimaryLight
      : ThemeLight.colorPrimaryLight;

  static Color get colorPrimaryLighter => userData.isDarkMode
      ? ThemeDark.colorPrimaryLighter
      : ThemeLight.colorPrimaryLighter;
}

class ThemeDark {
  static Color get colorPrimaryDark => const Color(0xFF1d1f22);
  static Color get colorPrimaryLight => const Color(0xFF2b2d31);
  static Color get colorPrimaryLighter => const Color(0xFF313339);

  static Color get colorAppBar => ThemeDark.colorPrimaryLight;
  static Color get colorIcons => Colors.white;
  static Color get colorIconsUnselected => Colors.white38;
}

class ThemeLight {
  static Color get colorPrimaryDark => const Color(0xFFf2f3f5);
  static Color get colorPrimaryLight => const Color(0xFFf7f7f7);
  static Color get colorPrimaryLighter =>
      const Color(0xFFf7f7f7); // todo: assign unique color
  static Color get colorAppBar => const Color(0XFFf2f2f6);
  static Color get colorIcons => Colors.blue;
  static Color get colorIconsUnselected => Colors.grey.shade400;
}
