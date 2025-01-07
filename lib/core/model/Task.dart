import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  static String collectionName = 'Task';
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Task({this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone = false});

  Task.fromFireBase(Map<String, dynamic> data)
      : this(
    id: data['id'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          dateTime: data['dateTime'] is int
              ? DateTime.fromMillisecondsSinceEpoch(data['dateTime'] as int)
              : (data['dateTime'] as Timestamp).toDate(),
          isDone: data['isDone'] as bool,
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
