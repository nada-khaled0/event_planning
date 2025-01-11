import 'package:flutter/material.dart';

import '../preference.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider(this.appTheme);

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    await SharedPreferenceClass.setTheme(newTheme == ThemeMode.dark);
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
