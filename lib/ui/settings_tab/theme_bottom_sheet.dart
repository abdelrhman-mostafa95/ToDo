import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/app_color.dart';
import 'package:todo_missions_list/core/provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  late ProviderList provider;

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
                provider.changeThemeMode(ThemeMode.light);
              },
              child: provider.currentTheme == ThemeMode.light
                  ? buildSelectedThemeItem('Light')
                  : buildUnSelectedThemeItem('Light')),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                provider.changeThemeMode(ThemeMode.dark);
              },
              child: provider.currentTheme == ThemeMode.dark
                  ? buildSelectedThemeItem('Dark')
                  : buildUnSelectedThemeItem('Dark'))
        ],
      ),
    );
  }

  Widget buildSelectedThemeItem(String selectedTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(selectedTheme,
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400)),
        Icon(
          Icons.check,
          size: 30,
          color: AppColor.primaryColor,
        )
      ],
    );
  }

  Widget buildUnSelectedThemeItem(String unselectedTheme) {
    var provider = Provider.of<ProviderList>(context);
    return Text(unselectedTheme,
        style: TextStyle(
            color: provider.currentTheme == ThemeMode.light
                ? AppColor.blackColor
                : AppColor.whiteColor,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400));
  }
}
