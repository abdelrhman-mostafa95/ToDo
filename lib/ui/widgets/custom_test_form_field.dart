import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';

import '../../core/constants/app_color.dart';

class CustomTestFormField extends StatelessWidget {
  String? Function(String?) validator;
  TextEditingController controller;
  String text;

  CustomTestFormField(
      {required this.validator, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      // controller: titleEnter,
      cursorColor: provider.currentTheme == ThemeMode.light
          ? AppColor.unSelectedColor
          : AppColor.whiteColor,
      style: TextStyle(
          color: provider.currentTheme == ThemeMode.light
              ? AppColor.blackColor
              : AppColor.whiteColor),
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: provider.currentTheme == ThemeMode.light
                    ? AppColor.blackColor
                    : AppColor.whiteColor,
                width: 2.0), // Focused underline color
          ),
          hintText: text,
          hintStyle: TextStyle(
              color: provider.currentTheme == ThemeMode.light
                  ? AppColor.darkColor
                  : AppColor.whiteColor)),
    );
  }
}
