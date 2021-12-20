import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData lightThem = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.orange,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.orange,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 1.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    
    type: BottomNavigationBarType.fixed,
  ),
  primarySwatch: defaultColor,
  textTheme: TextTheme(
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    ),
    bodyText1: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'jannah',
);
