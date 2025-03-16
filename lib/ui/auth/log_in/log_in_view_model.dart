import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/auth_provider.dart';
import '../../../firestore_storeg/firestore_usage.dart';
import '../sign_up/sign_up_dialog.dart';

class LogInViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late SignUpDialog navigator;

  void logIn(context) async {
    navigator.showLoading('Loading ...');
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var user =
          await FireStoreUsage.readUserFromFireBase(credential.user?.uid ?? '');
      if (user == null) {
        return;
      }
      var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      authProvider.updateUser(user);
      navigator.hideLoading();
      navigator.showMassage('Login Successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator.hideLoading();
        navigator.showMassage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator.hideLoading();
        navigator.showMassage('Wrong password provided for that user.');
      } else {
        navigator.hideLoading();
        navigator.showMassage(e.toString());
      }
    }
  }
}
