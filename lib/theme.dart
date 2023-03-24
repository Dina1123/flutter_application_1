import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: Colors.blue[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[900],
  ),
  buttonColor: Colors.blue[900],
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.blue[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  )),
  accentColor: Colors.blue[900],
  scaffoldBackgroundColor: Colors.grey[100],
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      color: Colors.blue[900],
    ),
    headline2: TextStyle(
      fontSize: 18,
      fontFamily: 'Open Sans',
      color: Colors.blueGrey[800],
    ),
    subtitle1: TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      color: Colors.grey[600],
    ),
  ),
);
