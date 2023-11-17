import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return ThemeData(
      useMaterial3: true,
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 40, 40, 40)
          : const Color.fromARGB(255, 245, 245, 245),
      colorScheme:
          isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
    );
  }
}
