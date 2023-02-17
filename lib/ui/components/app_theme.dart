import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  const primaryColor = Color(0xFF376AED);
  const primaryColorDark = Color(0xFF2D53B4);
  const primaryColorLight = Color(0xFF668CFC);
  const backgroundColor = Color.fromRGBO(255, 255, 255, 1);

  const textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: primaryColor,
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
