import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/firestore_storeg/firestore_usage.dart';

import '../../core/constants/app_color.dart';
import '../../core/model/Task.dart';
import '../../core/provider/provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late ProviderList provider;
  TextEditingController titleEnter = TextEditingController();
  TextEditingController descEnter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderList>(context);
    return SingleChildScrollView(
      child: Container(
        height: 800,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add new Task',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: provider.currentTheme == ThemeMode.light
                      ? AppColor.blackColor
                      : AppColor.whiteColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: TextFormField(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please, Enter your task title';
                      }
                      return null;
                    },
                    // controller: titleEnter,
                    onChanged: (text) {
                      title = text;
                    },
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
                              color:
                                  provider.currentTheme == ThemeMode.light
                                      ? AppColor.blackColor
                                      : AppColor.whiteColor,
                              width: 2.0), // Focused underline color
                        ),
                        hintText: 'Enter task Title',
                        hintStyle: TextStyle(
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.unSelectedColor
                                : AppColor.whiteColor)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: provider.currentTheme == ThemeMode.light
                      ? AppColor.blackColor
                      : AppColor.whiteColor,
                  style: TextStyle(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.blackColor
                          : AppColor.whiteColor),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please, Enter your task description';
                    }
                    return null;
                  },
                  // controller: descEnter,
                  onChanged: (text) {
                    description = text;
                  },
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor,
                            width: 2.0), // Focused underline color
                      ),
                      hintText: 'Enter task Description',
                      hintStyle: TextStyle(
                          color: provider.currentTheme == ThemeMode.light
                              ? AppColor.unSelectedColor
                              : AppColor.whiteColor)),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select time',
                    style: TextStyle(
                        color: provider.currentTheme == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showData();
                    },
                    child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.unSelectedColor
                                : AppColor.whiteColor)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor),
                    child: Text(
                      'Add',
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: AppColor.whiteColor),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void addTask() {
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      FireStoreUsage.addTaskToFireStore(task).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          print('task added successfully');
          provider.getTaskFromFireBase();
          print(task);
          print(task.dateTime);
        },
      );
      Navigator.pop(context);
  }

  void showData() async {
    var chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialDate: DateTime.now());
    selectedDate = chosenDate ?? selectedDate;
    print('$selectedDate');
    setState(() {});
  }
}
