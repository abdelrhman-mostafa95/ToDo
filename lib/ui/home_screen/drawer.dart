import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/app_color.dart';
import 'package:todo_missions_list/core/provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String fullName = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchFullName();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return DrawerHeader(
      decoration: BoxDecoration(
        color: provider.currentTheme == ThemeMode.light
            ? AppColor.backgroundLightColor
            : AppColor.blackColor,
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/mypic.jpg'),
            radius: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(fullName,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: provider.currentTheme == ThemeMode.light
                    ? AppColor.blackColor
                    : AppColor.whiteColor,
              )),
        ],
      ),
    );
  }

  void fetchFullName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        fullName = user.displayName ?? "Guest";
      });
    }
  }
}
