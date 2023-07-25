import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder/constants/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.whiteColor,
  brightness: Brightness.light,
  primaryColor: AppColor.primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.secondaryColor))),
  fontFamily: 'PR',
  tabBarTheme: const TabBarTheme(
    labelColor: AppColor.primaryColor,
    unselectedLabelColor: AppColor.blackColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: AppColor.primaryColor,
        width: 2.0,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark),
    backgroundColor: AppColor.whiteColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: AppColor.blackColor,
    ),
    titleTextStyle: TextStyle(
      color: AppColor.blackColor,
      fontSize: 18.0,
      fontFamily: 'PR',
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.secondaryColor),
    ),
    border: OutlineInputBorder(),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.bgColor,
  brightness: Brightness.dark,
  primaryColor: AppColor.primaryColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.secondaryColor))),
  fontFamily: 'PR',
  tabBarTheme: const TabBarTheme(
    labelColor: AppColor.primaryColor,
    unselectedLabelColor: AppColor.blackColor,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: AppColor.primaryColor,
        width: 2.0,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: AppColor.primaryColor,
        statusBarIconBrightness: Brightness.dark),
    backgroundColor: AppColor.primaryColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: AppColor.blackColor,
    ),
    titleTextStyle: TextStyle(
      color: AppColor.blackColor,
      fontSize: 18.0,
      fontFamily: 'PR',
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.secondaryColor),
    ),
    border: OutlineInputBorder(),
  ),
);
