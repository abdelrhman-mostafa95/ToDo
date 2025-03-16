import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_missions_list/ui/auth/sign_up/sign_up_dialog.dart';

import '../../../core/model/my_user.dart';
import '../../../firestore_storeg/firestore_usage.dart';

class SignUpViewModel extends ChangeNotifier {
  late SignUpDialog navigator;

  void signUp(String email, String password, String fullName) async {
    navigator.showLoading('Loading....');
    // DialogUtils.showLoading(context: context, message: 'Loading ...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      MyUser myUser = MyUser(
          id: credential.user?.uid ?? '', fullName: fullName, email: email);
      await FireStoreUsage.addUserToFireStore(myUser);
      navigator.hideLoading();
      // DialogUtils.hideLoading(context);
      navigator.showMassage('Register Successfully ..');
      // DialogUtils.showMessage(
      //     context: context,
      //     message: 'Register Successfully ..',
      //     posActionName: 'Ok',
      //     posAction: () {
      //       Navigator.pushNamed(context, HomeScreen.routeName);
      //     });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMassage('The password provided is too weak.');
        // DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(
        //     context: context,
        //     message: 'The password provided is too weak.',
        //     posActionName: 'Ok');
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMassage('The account already exists for that email.');
        // DialogUtils.hideLoading(context);
        // DialogUtils.showMessage(
        //     context: context,
        //     message: 'The account already exists for that email.',
        //     posActionName: 'Ok');
        // print('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMassage(e.toString());
      // DialogUtils.hideLoading(context);
      // DialogUtils.showMessage(
      //     context: context, message: e.toString(), posActionName: 'Ok');
      // print(e);
    }
  }
}
