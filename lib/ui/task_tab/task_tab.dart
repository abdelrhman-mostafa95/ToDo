import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import '../widgets/task_item.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
          locale: 'en',
          initialDate: DateTime.now(),
          onDateChange: (value) {},
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
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
                itemCount: 4, itemBuilder: (context, index) => TaskItem()))
      ],
    );
  }
}
