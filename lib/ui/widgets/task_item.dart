import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/model/Task.dart';
import 'package:todo_missions_list/firestore_storeg/firestore_usage.dart';
import 'package:todo_missions_list/ui/task_tab/edit_task.dart';

import '../../../core/constants/app_color.dart';
import '../../core/provider/auth_provider.dart';
import '../../core/provider/provider.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthUserProvider>(context);
    var provider = Provider.of<ProviderList>(context);
    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.5,
          // A motion is a widget used to control how the pane animates.
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              flex: 2,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 20),
              onPressed: (context) {
                FireStoreUsage.deleteData(widget.task,authProvider.currentUser?.id?? '').timeout(
                  const Duration(seconds: 1),
                  onTimeout: () => provider.getTaskFromFireBase(authProvider.currentUser?.id?? ''),
                );
              },
              backgroundColor: AppColor.redColor,
              foregroundColor: AppColor.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              flex: 2,
              padding: EdgeInsets.symmetric(vertical: 20),
              onPressed: (context) {
                Navigator.of(context)
                    .pushNamed(EditTask.routeName, arguments: widget.task);
                provider.getTaskFromFireBase(authProvider.currentUser?.id?? '');
                print('task will edit');
              },
              backgroundColor: provider.currentTheme == ThemeMode.light
                  ? AppColor.primaryColor
                  : AppColor.primaryColorDark,
              foregroundColor: AppColor.whiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: widget.task.isDone
                    ? AppColor.greenColor
                    : AppColor.primaryColor,
                margin: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width * 0.01,
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: widget.task.isDone == true
                              ? AppColor.greenColor
                              : AppColor.primaryColor)),
                  Text(
                    widget.task.description,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        color: provider.currentTheme == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor),
                  ),
                ],
              )),
              InkWell(
                onTap: () {
                  widget.task = Task(
                      id: widget.task.id,
                      title: widget.task.title,
                      description: widget.task.description,
                      dateTime: widget.task.dateTime,
                      isDone: true);
                  print(widget.task.id);
                  print('yes');
                  FireStoreUsage.updateIsDone(widget.task,authProvider.currentUser?.id?? '');
                  provider.getTaskFromFireBase(authProvider.currentUser?.id?? '');
                  print(widget.task.isDone);
                  print(widget.task.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                      horizontal: MediaQuery.of(context).size.width * 0.04),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.task.isDone == true
                        ? provider.currentTheme == ThemeMode.light
                            ? AppColor.whiteColor
                            : AppColor.blackColor
                        : AppColor.primaryColor,
                  ),
                  child: widget.task.isDone == true
                      ? Text(
                          'DONE!',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              color: AppColor.greenColor),
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 35,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
