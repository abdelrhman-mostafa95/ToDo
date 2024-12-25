import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../settings_tab/settings_tab.dart';
import '../task_tab/task_tab.dart';
import '../widgets/add_task.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: MediaQuery.of(context).size.height * 0.18,
          title: Text(
            'To Do List',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTaskBottomSheet();
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: AppColor.whiteColor,
          ),
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(color: AppColor.whiteColor, width: 4)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.list,
                      size: 22,
                    ),
                    label: "Menu"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: 22,
                    ),
                    label: "Settings"),
              ],
            ),
          ),
        ),
        body: SafeArea(child: selectedIndex == 0 ? TaskTab() : SettingsTab()));
  }

  void addTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTask(),
    );
  }
}
