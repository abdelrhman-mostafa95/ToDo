import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';

import '../../core/constants/app_color.dart';
import '../widgets/add_task.dart';
import '../widgets/task_item.dart';

class TaskTab extends StatefulWidget {
  static const String routeName = 'taskTab';

  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    if (provider.taskList.isEmpty) {
      provider.getTaskFromFireBase();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back,
        ),
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
      body: SafeArea(
        child: Column(
          children: [
            EasyDateTimeLine(
              locale: 'en',
              initialDate: provider.selectedDate,
              onDateChange: (selectedDate) {
                provider.changeSelectedDate(selectedDate);
              },
              headerProps: EasyHeaderProps(
                  monthStyle: TextStyle(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor),
                  selectedDateStyle: TextStyle(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor),
                  dateFormatter: DateFormatter.fullDateMDY(),
                  showMonthPicker: true,
                  showSelectedDate: true,
                  showHeader: true,
                  monthPickerType: MonthPickerType.dropDown),
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
}
