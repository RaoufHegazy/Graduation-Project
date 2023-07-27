import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightmode= ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 25,
      ),
      // status bar
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        selectedIconTheme: IconThemeData(
          size: 30,
        )

    ),

    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          fontFamily: 'angelina'
        ),
        bodyText2: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,),


    )

);
ThemeData darkmode = ThemeData(
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backgroundColor:HexColor('333739'),
    elevation: 0,
    titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25,
    ),
    // status bar
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      selectedIconTheme: IconThemeData(
        size: 30,
      )

  ),


  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
      bodyText2: TextStyle(
          color: Colors.white
      )

  ),

);