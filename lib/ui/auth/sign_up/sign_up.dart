import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/dialog_utils.dart';
import 'package:todo_missions_list/ui/auth/log_in/login.dart';
import 'package:todo_missions_list/ui/auth/sign_up/sign_up_dialog.dart';
import 'package:todo_missions_list/ui/auth/sign_up/sign_up_view_model.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/provider/provider.dart';
import '../../widgets/custom_test_form_field.dart';

class SignUp extends StatefulWidget {
  static const String routeName = 'Signin';

  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> implements SignUpDialog {
  SignUpViewModel viewModel = SignUpViewModel();
  var formKeyValidate = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
      ),
    );
  }

  void validatorTestField() async {
    if (formKeyValidate.currentState?.validate() == true) {
      viewModel.signUp(emailController.text, passwordController.text,
          fullNameController.text);
      // DialogUtils.showLoading(context: context, message: 'Loading ...');
      // try {
      //   final credential =
      //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailController.text,
      //     password: passwordController.text,
      //   );
      //
      //   MyUser myUser = MyUser(id: credential.user?.uid ?? '',
      //       fullName: fullNameController.text,
      //       email: emailController.text);
      //   await FireStoreUsage.addUserToFireStore(myUser);
      //   DialogUtils.hideLoading(context);
      //   DialogUtils.showMessage(
      //       context: context,
      //       message: 'Register Successfully ..',
      //       posActionName: 'Ok',
      //       posAction: () {
      //         Navigator.pushNamed(context, HomeScreen.routeName);
      //       });
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     DialogUtils.hideLoading(context);
      //     DialogUtils.showMessage(
      //         context: context,
      //         message: 'The password provided is too weak.',
      //         posActionName: 'Ok');
      //     print('The password provided is too weak.');
      //   } else if (e.code == 'email-already-in-use') {
      //     DialogUtils.hideLoading(context);
      //     DialogUtils.showMessage(
      //         context: context,
      //         message: 'The account already exists for that email.',
      //         posActionName: 'Ok');
      //     print('The account already exists for that email.');
      //   }
      // } catch (e) {
      //   DialogUtils.hideLoading(context);
      //   DialogUtils.showMessage(
      //       context: context, message: e.toString(), posActionName: 'Ok');
      //   print(e);
      // }
    }
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String massage) {
    // TODO: implement showLoading
    DialogUtils.showLoading(context: context, message: massage);
  }

  @override
  void showMassage(String massage) {
    // TODO: implement showMassage
    DialogUtils.showMessage(
      context: context,
      message: massage,
    );
  }
}
