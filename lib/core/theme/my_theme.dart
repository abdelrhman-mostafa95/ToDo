import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class MyTheme {
  static final LightTheme = ThemeData(
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.backgroundLightColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColor.blackColor),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.unSelectedColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColor.backgroundLightColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColor.primaryColor, width: 3),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)))));
  static final DarkTheme = ThemeData(
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.blackColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        backgroundColor: AppColor.primaryColorDark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: AppColor.unSelectedColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColor.blackColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColor.primaryColor, width: 3),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)))));
}
