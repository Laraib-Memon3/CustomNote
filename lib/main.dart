import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'presentation/providers/notes_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/home_screen.dart';

/// Main entry point for the CustomNote application.
void main() {
  runApp(const CustomNoteApp());
}

/// The root widget of the CustomNote application.
///
/// Sets up the MultiProvider for state management and configures
/// the app with theme support.
class CustomNoteApp extends StatelessWidget {
  const CustomNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: themeProvider.theme,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
