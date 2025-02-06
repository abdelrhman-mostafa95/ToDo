import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_missions_list/core/model/Task.dart';
import 'package:todo_missions_list/core/model/my_user.dart';

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

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUserCollection().doc(myUser.id).set(myUser);
  }
}
