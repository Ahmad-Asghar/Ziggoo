import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: const Color(0xFF00C065),
  secondaryHeaderColor: const Color(0xFF00C065),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(
      0xFF00C065))),
  colorScheme: const ColorScheme.light(primary: Color(0xFF00C065), secondary: Color(0xFF00C065)).copyWith(background:  Colors.white).copyWith(error: const Color(0xFFE84D4F)),
);