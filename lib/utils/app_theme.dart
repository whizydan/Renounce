import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  static bool _isDark = false;
  static const Color _accent = Color(0xFF677E74);

  /// Call this during app initialization
  static Future<void> loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDarkTheme') ?? false;
  }

  /// Optionally allow updating theme preference
  static Future<void> setTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
    _isDark = isDark;
  }

  static bool get isDark => _isDark;

  static Color background() => _isDark ? Colors.black : Colors.white;

  static Color textColour() => _isDark ? Colors.white : Colors.black;

  static Color accentColour() => _accent;
}
