import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/dialog_utils.dart';
import 'package:todo_missions_list/core/provider/provider.dart';
import 'package:todo_missions_list/ui/auth/log_in/log_in_view_model.dart';
import 'package:todo_missions_list/ui/auth/sign_up/sign_up.dart';
import 'package:todo_missions_list/ui/auth/sign_up/sign_up_dialog.dart';
import 'package:todo_missions_list/ui/home_screen/home_screen.dart';
import 'package:todo_missions_list/ui/widgets/custom_test_form_field.dart';

import '../../../core/constants/app_color.dart';

class Login extends StatefulWidget {
  static const String routeName = 'Login';

  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements SignUpDialog {
  var formKeyValidate = GlobalKey<FormState>();

  LogInViewModel viewModel = LogInViewModel();

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
        appBar: AppBar(),
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
                      'Welcom to ToDo LiSt!',
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
                        controller: viewModel.emailController,
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
                        controller: viewModel.passwordController,
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
                      child: Text("Log in",
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
                    Row(
                      children: [
                        Text("You don't have an account ?",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: provider.currentTheme == ThemeMode.light
                                    ? AppColor.blackColor
                                    : AppColor.whiteColor,
                                fontSize: 12)),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SignUp.routeName);
                          },
                          child: Text(" Create account!",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color:
                                      provider.currentTheme == ThemeMode.light
                                          ? AppColor.blackColor
                                          : AppColor.whiteColor,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        // validatorTestField();
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                      child: Text("Home",
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
      viewModel.logIn(context);
      // DialogUtils.showLoading(context: context, message: 'Loading ...');
      // try {
      //   final credential = await FirebaseAuth.instance
      //       .signInWithEmailAndPassword(
      //           email: emailController.text, password: passwordController.text);
      //   var user = await FireStoreUsage.readUserFromFireBase(credential.user?.uid ?? '');
      //   if(user == null){
      //     return;
      //   }
      //   var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      //   authProvider.updateUser(user);
      //   DialogUtils.hideLoading(context);
      //   DialogUtils.showMessage(
      //       context: context,
      //       message: 'Login Successfully.',
      //       posActionName: 'Ok',
      //       posAction: () {
      //         Navigator.pushNamed(context, HomeScreen.routeName);
      //       });
      //   print(credential.user?.displayName ?? '');
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     DialogUtils.hideLoading(context);
      //     DialogUtils.showMessage(
      //         context: context, message: 'No user found for that email.');
      //     print('No user found for that email.');
      //   } else if (e.code == 'wrong-password') {
      //     DialogUtils.hideLoading(context);
      //     DialogUtils.showMessage(
      //         context: context,
      //         message: 'Wrong password provided for that user.');
      //     print('Wrong password provided for that user.');
      //   }
      //   else  {
      //     DialogUtils.hideLoading(context);
      //     DialogUtils.showMessage(context: context, message: e.code.toString());
      //     print(e.toString());
      //   }
      // }
    }
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    // TODO: implement showLoading
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMassage(String message) {
    // TODO: implement showMassage
    DialogUtils.showMessage(context: context, message: message);
  }
}
