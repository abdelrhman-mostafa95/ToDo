import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';

import '../widgets/task_item.dart';

class TaskTab extends StatefulWidget {
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
    return Column(
      children: [
        EasyDateTimeLine(
          locale: 'en',
          initialDate: provider.selectedDate,
          onDateChange: (selectedDate) {
            provider.changeSelectedDate(selectedDate);
          },
          headerProps: const EasyHeaderProps(
              dateFormatter: DateFormatter.fullDateMDY(),
              showMonthPicker: true,
              showHeader: true,
              monthPickerType: MonthPickerType.dropDown),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.monthDayNumDayStr,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff5D9CEC),
                    Color(0xff355b88),
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
    );
  }
}
