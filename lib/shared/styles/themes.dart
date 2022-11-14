

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';
import 'package:udemy_flutterr/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
primarySwatch: defaultColor,

scaffoldBackgroundColor: Colors.white,
appBarTheme: AppBarTheme(

backwardsCompatibility: false,
systemOverlayStyle: SystemUiOverlayStyle(
statusBarColor: Colors.white,
statusBarIconBrightness: Brightness.dark,
),
backgroundColor: Colors.white,
elevation: 0.0,
titleTextStyle: TextStyle(
    fontFamily: 'Jannah',
color: Colors.black,
fontSize: 25,
fontWeight: FontWeight.bold),
iconTheme: IconThemeData(
color: Colors.black,
),
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
//selectedItemColor: Colors.deepOrange,
selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.black38,
elevation: 20,
backgroundColor: Colors.white,
),
textTheme: TextTheme(
headline6: TextStyle(
  fontFamily: 'Jannah',
fontSize: 20,
fontWeight: FontWeight.w600,
color: Colors.black,
),
  subtitle1: TextStyle(
    fontFamily: 'Jannah',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.4,
  ),
),
  fontFamily: 'Jannah'
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,

  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontFamily: 'Jannah',
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      fontFamily: 'Jannah',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Jannah',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.4,
    ),
  ),

  fontFamily: 'Jannah'
);