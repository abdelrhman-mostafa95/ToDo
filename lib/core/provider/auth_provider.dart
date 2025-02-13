import 'package:flutter/cupertino.dart';
import 'package:todo_missions_list/core/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier {
  MyUser? currentUser;

 void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
