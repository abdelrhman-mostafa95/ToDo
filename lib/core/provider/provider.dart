import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firestore_storeg/firestore_usage.dart';
import '../model/Task.dart';

class ProviderList extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();
  ThemeMode currentTheme = ThemeMode.light;

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
          print('Iam in true');
          return true;
        }
        return false;
      },
    ).toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    getTaskFromFireBase();
  }

  changeThemeMode(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    saveTheme(currentTheme);
    notifyListeners();
  }

  saveTheme(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (theme == ThemeMode.light) {
      await prefs.setString("theme", "light");
    } else {
      await prefs.setString("theme", "dark");
    }
  }

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString("theme") ?? "light";
    if (theme == 'light') {
      currentTheme = ThemeMode.light;
    } else {
      currentTheme = ThemeMode.dark;
      print(currentTheme.toString());
    }
    notifyListeners();
  }
}
