import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/provider/provider.dart';
import 'package:todo_missions_list/core/theme/my_theme.dart';
import 'package:todo_missions_list/ui/auth/login.dart';
import 'package:todo_missions_list/ui/auth/signin.dart';
import 'package:todo_missions_list/ui/home_screen/home_screen.dart';
import 'package:todo_missions_list/ui/settings_tab/settings_tab.dart';
import 'package:todo_missions_list/ui/task_tab/add_task_home_screen.dart';
import 'package:todo_missions_list/ui/task_tab/task_tab.dart';
import 'package:todo_missions_list/ui/task_tab/edit_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBBogA1UQRqRM2rjmaF8KhbK-soEq4CTQo',
              appId: 'com.example.todo_missions_list',
              messagingSenderId: '361704001394',
              projectId: 'todo-missions'))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => ProviderList()..getTheme(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.LightTheme,
      darkTheme: MyTheme.DarkTheme,
      themeMode: provider.currentTheme,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        EditTask.routeName: (_) => const EditTask(),
        TaskTab.routeName: (_) => const TaskTab(),
        SettingsTab.routeName: (_) => const SettingsTab(),
        HomeScreenAddTask.routeName: (_) => const HomeScreenAddTask(),
        Login.routeName: (_) => Login(),
        SignIn.routeName: (_) => SignIn(),
      },
    );
  }
}
