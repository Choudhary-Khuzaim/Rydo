import 'package:flutter/material.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.light,
  );

  static void setTheme(String themeStr) {
    if (themeStr == "Dark Mode") {
      themeMode.value = ThemeMode.dark;
    } else if (themeStr == "Light Mode") {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.system;
    }
  }

  static String getThemeName() {
    switch (themeMode.value) {
      case ThemeMode.dark:
        return "Dark Mode";
      case ThemeMode.light:
        return "Light Mode";
      case ThemeMode.system:
        return "System Default";
    }
  }
}
