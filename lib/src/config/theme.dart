import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.black,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 20.0)
      ),
      useMaterial3: true,
    );
  }
}
