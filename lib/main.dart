import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_missions_list/core/theme/my_theme.dart';
import 'package:todo_missions_list/ui/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: 'AIzaSyBBogA1UQRqRM2rjmaF8KhbK-soEq4CTQo',
              appId: 'com.example.todo_missions_list',
              messagingSenderId: '361704001394',
              projectId: 'todo-missions'))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.LightTheme,
      home: HomeScreen(),
    );
  }
}
