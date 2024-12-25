import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class MyTheme {
  static final LightTheme = ThemeData(
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: AppColor.backgroundLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.primaryColor,
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
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColor.primaryColor, width: 3),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)))));
}
