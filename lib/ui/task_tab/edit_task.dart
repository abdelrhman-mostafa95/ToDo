import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/ui/home_screen/home_screen.dart';

import '../../core/constants/app_color.dart';
import '../../core/model/Task.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/provider/provider.dart';
import '../../firestore_storeg/firestore_usage.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'editTask';

  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var selectedDate = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late ProviderList provider;

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)!.settings.arguments as Task;
    title.text = task.title;
    description.text = task.description;
    provider = Provider.of<ProviderList>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Edit Your Task',
                style: TextStyle(
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    cursorColor: provider.currentTheme == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please, Enter your new task title';
                      }
                      return null;
                    },
                    initialValue: task.title,
                    style: TextStyle(
                        color: provider.currentTheme == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                    onChanged: (value) {
                      task.title = value;
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  provider.currentTheme == ThemeMode.light
                                      ? AppColor.blackColor
                                      : AppColor.whiteColor,
                              width: 2.0), // Focused underline color
                        ),
                        hintText: 'Edit task Title',
                        hintStyle: TextStyle(
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.unSelectedColor
                                : AppColor.whiteColor)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    cursorColor: provider.currentTheme == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please, Enter your new task description';
                      }
                      return null;
                    },
                    initialValue: task.description,
                    style: TextStyle(
                        color: provider.currentTheme == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                    onChanged: (value) {
                      task.description = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor,
                            width: 2.0), // Focused underline color
                      ),
                    ),
                    maxLines: 2,
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
                              color:
                                  provider.currentTheme == ThemeMode.light
                                      ? AppColor.blackColor
                                      : AppColor.whiteColor)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        saveChanges(task);
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              provider.currentTheme == ThemeMode.light
                                  ? AppColor.backgroundLightColor
                                  : AppColor.blackColor),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 20,
                            fontFamily: 'Pacifico',
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showData() async {
    var chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        initialDate: DateTime.now());
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }

  void saveChanges(Task task) async {
    var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      Task newTask = Task(
          title: title.text,
          description: description.text,
          dateTime: selectedDate,
          id: task.id);
      print(task.id);
      await FireStoreUsage.updateTask(newTask,authProvider.currentUser?.id?? '').timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          provider.getTaskFromFireBase(authProvider.currentUser?.id?? '');
          print(task.id);
          Navigator.pop(context);
        },
      );
  }
}
