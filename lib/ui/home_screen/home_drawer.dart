import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/app_color.dart';
import 'package:todo_missions_list/core/provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return SafeArea(
      child: Column(
        children: [
          Text('Hello, MR',style: TextStyle(
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: provider.currentTheme == ThemeMode.light
            ? AppColor.blackColor
            : AppColor.whiteColor,
      )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text('AbdelRahman Mostafa',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: provider.currentTheme == ThemeMode.light
                    ? AppColor.blackColor
                    : AppColor.whiteColor,
              )),
        ],
      ),
    );
  }
}
