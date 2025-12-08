import 'package:custom_note/screens/AddNoteScreen.dart';
import 'package:custom_note/screens/HomeScreen.dart';
import 'package:custom_note/screens/SigninScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CustomNoteApp());
}

class CustomNoteApp extends StatelessWidget {
  const CustomNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CustomNote',
      theme: ThemeData(
        primaryColor: const Color(0xFF4F46E5),
        fontFamily: 'Roboto',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB), // Light gray background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/customnote_logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  height: 100,
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'CustomNote',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Subtitle
                const Text(
                  'Make notes that feel like you\nChoose your theme and text size to get started.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),

                // Theme Selection
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Choose a theme',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _themeBox('Light', Colors.white, Colors.black),
                    _themeBox('Dark', Colors.black, Colors.black),
                    _themeBox(
                      'Pastel',
                      null, // no solid color
                      Colors.black,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFDBEAFE), // top color
                          Color(0xFFF3E8FF), // bottom color
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Text Size Selection
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Text size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),

                // Segmented Control (Small, Medium, Large)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textSizeOption('Small', false),
                      _textSizeOption('Medium', true),
                      _textSizeOption('Large', false),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNoteScreen(),
                          // SigninScreen(),
                          //HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Theme Box Widget
  static Widget _themeBox(
    String label,
    Color? bgColor,
    Color textColor, {
    Gradient? gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey, // border color
          width: 2, // border thickness
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: gradient == null ? bgColor : null,
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }

  // Text Size Option Widget
  static Widget _textSizeOption(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4F46E5) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
