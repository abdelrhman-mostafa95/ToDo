import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_missions_list/core/constants/app_color.dart';
import 'package:todo_missions_list/core/provider/provider.dart';
import 'package:todo_missions_list/ui/settings_tab/theme_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  static const String routeName = 'settingsTab';

  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Theme',
                style: TextStyle(
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColor.blackColor
                        : AppColor.whiteColor,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              InkWell(
                onTap: () {
                  showThemeBottomSheet();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      color: provider.currentTheme == ThemeMode.light
                          ? AppColor.whiteColor
                          : AppColor.blackColor,
                      border: Border.all(color: AppColor.primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      provider.currentTheme == ThemeMode.light
                          ? 'Light'
                          : 'Dark',
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
