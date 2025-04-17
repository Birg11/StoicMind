import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() {
    final box = Hive.box('settings');
    _isDarkMode = box.get('darkMode', defaultValue: false);
  }

  void _saveToPrefs() {
    final box = Hive.box('settings');
    box.put('darkMode', _isDarkMode);
  }
}