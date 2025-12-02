import 'package:flutter/material.dart';

/// App-wide color constants for the CustomNote application.
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryLight = Color(0xFF6200EE);
  static const Color primaryDark = Color(0xFFBB86FC);
  static const Color primaryPastel = Color(0xFFE8D5E7);

  // Secondary Colors
  static const Color secondaryLight = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF018786);
  static const Color secondaryPastel = Color(0xFFB2DFDB);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color backgroundPastel = Color(0xFFFFF8E7);

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color surfacePastel = Color(0xFFFFFDF7);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textPrimaryPastel = Color(0xFF5D4037);

  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textSecondaryPastel = Color(0xFF8D6E63);

  // Note Tag Colors
  static const List<Color> noteTagColors = [
    Color(0xFFFFCDD2), // Light Red
    Color(0xFFFFE0B2), // Light Orange
    Color(0xFFFFF9C4), // Light Yellow
    Color(0xFFC8E6C9), // Light Green
    Color(0xFFB3E5FC), // Light Blue
    Color(0xFFE1BEE7), // Light Purple
    Color(0xFFFFCCBC), // Light Coral
    Color(0xFFD7CCC8), // Light Brown
  ];

  // Error Colors
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color errorPastel = Color(0xFFFFAB91);
}

/// App-wide string constants.
class AppStrings {
  AppStrings._();

  static const String appName = 'CustomNote';
  static const String newNote = 'New Note';
  static const String editNote = 'Edit Note';
  static const String deleteNote = 'Delete Note';
  static const String saveNote = 'Save';
  static const String cancel = 'Cancel';
  static const String titleHint = 'Enter title...';
  static const String contentHint = 'Start writing your note...';
  static const String noNotes = 'No notes yet. Tap + to create one!';
  static const String confirmDelete = 'Are you sure you want to delete this note?';
  static const String settings = 'Settings';
  static const String theme = 'Theme';
  static const String lightMode = 'Light';
  static const String darkMode = 'Dark';
  static const String pastelMode = 'Pastel';
  static const String selectColor = 'Select Color';
  static const String select = 'Select';
  static const String delete = 'Delete';
  static const String searchNotes = 'Search notes...';
  static const String noNotesFound = 'No notes found';
  static const String discardChanges = 'Discard changes?';
  static const String unsavedChanges = 'You have unsaved changes. Do you want to discard them?';
  static const String keepEditing = 'Keep editing';
  static const String discard = 'Discard';
}

/// App-wide dimension constants.
class AppDimensions {
  AppDimensions._();

  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Card
  static const double cardElevation = 2.0;
  static const double noteCardHeight = 140.0;

  // Icon
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;

  // Color Picker
  static const double colorPickerItemSize = 40.0;
  static const double colorPickerSpacing = 8.0;
}
