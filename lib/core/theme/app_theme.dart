import 'package:flutter/material.dart';
import 'package:weather/core/constants/colors.dart';

class AppTheme {
  const AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Gilroy',
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: UIColors.black,
        elevation: 0.2,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w500, color: UIColors.black, fontSize: 17)),
  );

// static final darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: darkPrimaryColor,
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(foregroundColor: darkTextColor)),
//     colorScheme: ColorScheme.light(secondary: lightSecondaryColor)
//         .copyWith(background: darkBackgroundColor));
}
