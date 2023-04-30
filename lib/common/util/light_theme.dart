import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/util/shared_ui_constants.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: primaryColor,
    accentColor: secondaryColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Colors.black,
    ),
  ),
);
