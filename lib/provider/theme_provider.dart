import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const themeStatus = "THEMESTATUS";
  bool _darkTheme = false;

  bool get getIsDarkTheme => _darkTheme;

  ThemeProvider() {
    initTheme();
  }

  Future<void> initTheme() async {
    _darkTheme = await getTheme();
    notifyListeners();
  }

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _darkTheme = value;
    prefs.setBool(themeStatus, value);
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}
