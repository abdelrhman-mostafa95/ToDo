import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../firestore_storeg/firestore_usage.dart';
import '../model/Task.dart';

class ProviderList extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void getTaskFromFireBase() async {
    QuerySnapshot<Task> querySnapshot =
        await FireStoreUsage.getTaskCollection().get();
    taskList = querySnapshot.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    print('$taskList');
    taskList = taskList.where(
      (task) {
        if (selectedDate.day == task.dateTime.day &&
            selectedDate.month == task.dateTime.month &&
            selectedDate.year == task.dateTime.year) {
          return true;
        }
        print('hey');
        return false;
      },
    ).toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    getTaskFromFireBase();
  }
}
