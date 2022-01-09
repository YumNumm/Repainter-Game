import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey.withAlpha(50),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: materialWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
}

const locale = Locale('ja', 'JP');

const MaterialColor materialWhite = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
