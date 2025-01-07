import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';
import 'package:todo_missions_list/ui/task_tab/add_task_home_screen.dart';

import '../../core/constants/app_color.dart';
import '../auth/login.dart';
import '../settings_tab/settings_tab.dart';
import '../task_tab/task_tab.dart';
import 'drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fullName = "Loading...";
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchFullName();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: Container(
            color: provider.currentTheme == ThemeMode.light
                ? AppColor.backgroundLightColor
                : AppColor.blackColor,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                HomeDrawer(),
                buildDrawer(
                  provider,
                  Icons.list_alt,
                  'Task List',
                  () {
                    Navigator.pushNamed(context, TaskTab.routeName);
                  },
                ),
                buildDrawer(
                  provider,
                  Icons.settings_outlined,
                  'Settings',
                  () {
                    Navigator.pushNamed(context, SettingsTab.routeName);
                  },
                )
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Welcom Back!',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor,
                      fontSize: 40),
                )),
            Container(
                alignment: Alignment.center,
                child: Text(
                  fullName,
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor,
                      fontSize: 40),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Login.routeName);
              },
              child: Text(
                'login?!',
                style: TextStyle(
                    fontFamily: "Pacifico",
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    fontSize: 20),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomeScreenAddTask.routeName);
              },
              child: Text(
                'add task!',
                style: TextStyle(
                    fontFamily: "Pacifico",
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    fontSize: 30),
              ),
            )
          ],
        ));
  }

  buildDrawer(ProviderList provider, IconData icon, String title,
      void Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: provider.currentTheme == ThemeMode.light
            ? AppColor.blackColor
            : AppColor.whiteColor,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
            fontSize: 20,
            color: provider.currentTheme == ThemeMode.light
                ? AppColor.blackColor
                : AppColor.whiteColor),
      ),
      onTap: onTap,
    );
  }

  void fetchFullName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        fullName = user.displayName ?? "Guest";
      });
    }
  }
}