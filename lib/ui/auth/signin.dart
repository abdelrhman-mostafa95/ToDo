import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/dialog_utils.dart';
import 'package:todo_missions_list/core/model/my_user.dart';
import 'package:todo_missions_list/firestore_storeg/firestore_usage.dart';
import 'package:todo_missions_list/ui/auth/login.dart';
import 'package:todo_missions_list/ui/home_screen/home_drawer.dart';
import 'package:todo_missions_list/ui/home_screen/home_screen.dart';

import '../../core/constants/app_color.dart';
import '../../core/provider/provider.dart';
import '../widgets/custom_test_form_field.dart';

class SignIn extends StatefulWidget {
  static const String routeName = 'Signin';

  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKeyValidate = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return Scaffold(
      body: Form(
        key: formKeyValidate,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello to ToDo LiSt!',
                    style: TextStyle(
                        fontFamily: "Pacifico",
                        color: provider.currentTheme == ThemeMode.light
                            ? AppColor.blackColor
                            : AppColor.whiteColor,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  CustomTestFormField(
                      controller: fullNameController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please, Enter your name';
                        }
                        return null;
                      },
                      text: 'Full Name'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTestFormField(
                      controller: emailController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please, Enter your email';
                        }
                        return null;
                      },
                      text: 'Email'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTestFormField(
                      controller: passwordController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please, Enter your password';
                        }
                        if (input.length < 6) {
                          return 'Password must be more than 6 char';
                        }
                        return null;
                      },
                      text: 'Password'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      validatorTestField();
                    },
                    child: Text("Sign in",
                        style: TextStyle(
                            fontFamily: "Pacifico",
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor,
                            fontSize: 20)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Login.routeName);
                    },
                    child: Text("Log in ?!",
                        style: TextStyle(
                            fontFamily: "Pacifico",
                            color: provider.currentTheme == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor,
                            fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validatorTestField() async {
    if (formKeyValidate.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading ...');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(id: credential.user?.uid ?? '',
            fullName: fullNameController.text,
            email: emailController.text);
        await FireStoreUsage.addUserToFireStore(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            message: 'Register Successfully ..',
            posActionName: 'Ok',
            posAction: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The password provided is too weak.',
              posActionName: 'Ok');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              posActionName: 'Ok');
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context, message: e.toString(), posActionName: 'Ok');
        print(e);
      }
    }
  }
}
