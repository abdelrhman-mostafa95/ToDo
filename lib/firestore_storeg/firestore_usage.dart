import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_missions_list/core/model/Task.dart';

class FireStoreUsage {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireBase(snapshot.data()!),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTaskCollection();
    DocumentReference<Task> taskId = taskCollection.doc();
    task.id = taskId.id;
    return taskId.set(task);
  }

  static updateIsDone(Task task) async {
    await getTaskCollection()
        .doc(task.id)
        .update({'isDone': true})
        .then((value) => print("User Updated "))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static deleteData(Task task) async {
    await getTaskCollection()
        .doc(task.id)
        .delete()
        .then((value) => print("User Updated "))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static updateTask(Task task) async {
    await getTaskCollection()
        .doc(task.id)
        .update({
          'title': task.title,
          'description': task.description,
          'dateTime': task.dateTime,
          'id': task.id
        })
        .then((value) => print("User Updated "))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
