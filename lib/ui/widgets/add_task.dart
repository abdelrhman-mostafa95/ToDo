import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';

  // late TaskProvider provider;

  @override
  Widget build(BuildContext context) {
    // provider = Provider.of<TaskProvider>(context);
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add new Task',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            ),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please, Enter your task title';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        title = text;
                      },
                      decoration: InputDecoration(hintText: 'Enter task Title'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please, Enter your task description';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        description = text;
                      },
                      decoration:
                          InputDecoration(hintText: 'Enter task Description'),
                      maxLines: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select time',
                        style: TextStyle(
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
                                color: AppColor.unSelectedColor)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              color: AppColor.whiteColor),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor),
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
      // Task task = Task(
      //     title: title,
      //     description: description,
      //     dateTime: selectedDate);
      // FirebaseUtils.addTaskToFireBase(task).timeout(Duration(seconds: 2), onTimeout: () {
      //   print('task added successfully');
      //   // provider.getTaskFromFireBase();
      // },);
      Navigator.pop(context);
    }
  }

  void showData() async {
    var chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        initialDate: DateTime.now());
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
