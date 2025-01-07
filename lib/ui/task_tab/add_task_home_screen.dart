import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';
import 'package:todo_missions_list/ui/task_tab/task_tab.dart';

import '../../core/constants/app_color.dart';
import '../../core/model/Task.dart';
import '../../firestore_storeg/firestore_usage.dart';

class HomeScreenAddTask extends StatefulWidget {
  static const String routeName = 'add task';

  const HomeScreenAddTask({super.key});

  @override
  State<HomeScreenAddTask> createState() => _HomeScreenAddTaskState();
}

class _HomeScreenAddTaskState extends State<HomeScreenAddTask> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late ProviderList provider;
  TextEditingController titleEnter = TextEditingController();
  TextEditingController descEnter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
            Form(
                key: formKey,
                child: Column(
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
                            ? AppColor.blackColor
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
                                    ? AppColor.darkColor
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
                                  ? AppColor.darkColor
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
                                    ? AppColor.darkColor
                                    : AppColor.whiteColor)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          addTask();
                          Navigator.pushNamed(context, TaskTab.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                provider.currentTheme == ThemeMode.light
                                    ? AppColor.backgroundLightColor
                                    : AppColor.blackColor),
                        child: Text(
                          'add',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 30,
                              fontFamily: 'Pacifico',
                              color: provider.currentTheme == ThemeMode.light
                                  ? AppColor.blackColor
                                  : AppColor.whiteColor),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
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
