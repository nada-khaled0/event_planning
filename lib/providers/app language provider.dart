import 'package:event_planning/preference.dart';
import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  AppLanguageProvider(this.appLanguage);

  void changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    await SharedPreferenceClass.setLanguage(newLanguage);
    notifyListeners();
  }
}
