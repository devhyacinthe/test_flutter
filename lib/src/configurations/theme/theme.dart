import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.grey.shade500,
      secondary: Colors.grey.shade400,
    ));
ThemeData darkMode = ThemeData(
    fontFamily: 'Roboto',
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.black38,
      primary: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
    ));
