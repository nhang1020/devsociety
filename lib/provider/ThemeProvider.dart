import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

List<ThemeMode> listMode = [ThemeMode.system, ThemeMode.light, ThemeMode.dark];

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(bool isDark, int indexColor) {
    if (isDark) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    toggleColor(indexColor);
    indexCl = indexColor;
  }
  ThemeMode themeMode = ThemeMode.dark;

  int indexCl = 0;
  bool get isSysDark =>
      themeMode == ThemeMode.system &&
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  toggleColor(int index, {BuildContext? context}) async {
    indexCl = index;

    notifyListeners();
  }

  toggleTheme(bool darkMode, int index, BuildContext context) async {
    if (darkMode) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
