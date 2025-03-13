import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';
import 'package:todo_missions_list/ui/auth/login.dart';
import 'package:todo_missions_list/ui/home_screen/home_drawer.dart';

import '../../core/constants/app_color.dart';
import '../../core/provider/auth_provider.dart';
import '../settings_tab/settings_tab.dart';
import '../widgets/add_task.dart';
import '../widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'taskTab';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthUserProvider>(context);
    var provider = Provider.of<ProviderList>(context);
    if (provider.taskList.isEmpty) {
      provider.getTaskFromFireBase(authProvider.currentUser?.id?? '');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskBottomSheet();
        },
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(
                color: provider.currentTheme == ThemeMode.light
                    ? AppColor.whiteColor
                    : AppColor.darkColor,
                width: 4)),
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColor.whiteColor,
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(top: 12),
          color: provider.currentTheme == ThemeMode.light
              ? AppColor.backgroundLightColor
              : AppColor.blackColor,
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              HomeDrawer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              buildDrawer(
                provider,
                Icons.list_alt,
                'Task List',
                    () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              buildDrawer(
                provider,
                Icons.settings_outlined,
                'Settings',
                    () {
                  Navigator.pushNamed(context, SettingsTab.routeName);
                },
              ),
              buildDrawer(
                provider,
                Icons.login,
                'Login',
                    () {
                  Navigator.pushNamed(context, Login.routeName);
                },
              ),
              buildDrawer(
                provider,
                Icons.logout,
                'Logout',
                    () {
                  provider.taskList = [];
                  authProvider.currentUser = null;
                  Navigator.pushNamed(context, Login.routeName);
                },
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            EasyDateTimeLine(
              locale: 'en',
              initialDate: provider.selectedDate,
              onDateChange: (selectedDate) {
                provider.changeSelectedDate(selectedDate,authProvider.currentUser?.id?? '');
              },

              headerProps: EasyHeaderProps(

                  monthStyle: TextStyle(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor),
                  selectedDateStyle: TextStyle(
                      color:provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor
                  ),
                  dateFormatter: DateFormatter.fullDateMDY(),
                  showMonthPicker: true,
                  showSelectedDate: true,
                  showHeader: true,
                  monthPickerType: MonthPickerType.switcher
              ),
              dayProps: EasyDayProps(
                todayHighlightColor: provider.currentTheme == ThemeMode.light
                    ? AppColor.blackColor
                    : AppColor.whiteColor,
                borderColor: Colors.white,
                dayStructure: DayStructure.monthDayNumDayStr,
                activeDayStyle: DayStyle(
                  dayStrStyle: TextStyle(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.blackColor,
                        AppColor.backgroundLightColor,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: provider.taskList.length,
                    itemBuilder: (context, index) => TaskItem(
                      task: provider.taskList[index],
                    )))
          ],
        ),
      ),
    );
  }

  void addTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTask(),
    );
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

}
