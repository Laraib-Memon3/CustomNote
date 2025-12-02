import 'package:flutter/material.dart';
import '../../core/themes/app_theme.dart';

/// Provider for managing theme state across the application.
///
/// Supports Light, Dark, and Pastel theme modes with persistence.
class ThemeProvider extends ChangeNotifier {
  /// Current theme mode.
  AppThemeMode _themeMode = AppThemeMode.light;

  /// Gets the current theme mode.
  AppThemeMode get themeMode => _themeMode;

  /// Gets the current ThemeData based on the theme mode.
  ThemeData get theme => AppTheme.getTheme(_themeMode);

  /// Gets the display name for the current theme mode.
  String get themeModeName {
    switch (_themeMode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.pastel:
        return 'Pastel';
    }
  }

  /// Sets the theme mode and notifies listeners.
  void setThemeMode(AppThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  /// Toggles through the available theme modes in order.
  void toggleTheme() {
    switch (_themeMode) {
      case AppThemeMode.light:
        setThemeMode(AppThemeMode.dark);
        break;
      case AppThemeMode.dark:
        setThemeMode(AppThemeMode.pastel);
        break;
      case AppThemeMode.pastel:
        setThemeMode(AppThemeMode.light);
        break;
    }
  }

  /// Checks if the current theme is dark mode.
  bool get isDarkMode => _themeMode == AppThemeMode.dark;

  /// Checks if the current theme is light mode.
  bool get isLightMode => _themeMode == AppThemeMode.light;

  /// Checks if the current theme is pastel mode.
  bool get isPastelMode => _themeMode == AppThemeMode.pastel;
}
