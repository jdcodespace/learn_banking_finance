import 'package:flutter/material.dart';
import 'package:learn_banking_finance/utils/color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: CColor.white,
  // backgroundColor: CColor.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: CColor.white,
    unselectedItemColor: CColor.black,
    selectedItemColor: CColor.black,
    elevation: 0,
  ),
  fontFamily: 'OpenSans',
  highlightColor: CColor.transparent,
  splashColor: CColor.transparent,
);
