import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  const primaryColor = Color(0xFF376AED);
  const primaryColorDark = Color(0xFF2D53B4);
  const primaryColorLight = Color(0xFFB1C4FE);
  const backgroundColor = Color(0xFFFFFFFF);
  const headlineTextColor = Color(0xFF0D253C);
  const subtitleTextColor = Color(0xFF2D4379);

  const textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: headlineTextColor,
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      color: subtitleTextColor,
    ),
    labelMedium: TextStyle(
      color: backgroundColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  const inputDecorationTheme = InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColorLight,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
      ),
    ),
    alignLabelWithHint: true,
  );

  const buttonTheme = ButtonThemeData(
    colorScheme: ColorScheme.light(primary: primaryColor),
    splashColor: primaryColorLight,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(48),
      ),
    ),
  );

  return ThemeData(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    primaryColorLight: primaryColorLight,
    scaffoldBackgroundColor: backgroundColor,
    backgroundColor: backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    buttonTheme: buttonTheme,
  );
}
