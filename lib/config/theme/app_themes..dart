import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Inter',
      appBarTheme: appBarTheme());
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Color(0XFF8B8B8B), fontSize: 18, fontWeight: FontWeight.w500),
  );
}
