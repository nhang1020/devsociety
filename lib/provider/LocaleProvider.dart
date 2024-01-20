import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider() {
    getLocale().then((_) => toggleLocale(locale));
  }
  String locale = "en";

  bool get isEn => locale == "en";

  Future<void> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = prefs.getString("locale") ?? "en";
    notifyListeners();
  }

  Future<void> toggleLocale(String locale) async {
    this.locale = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("locale", locale);
    notifyListeners();
  }
}
