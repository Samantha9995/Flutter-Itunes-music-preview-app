import 'package:flutter/material.dart';

// Copyright (c) 2025 SADev. All rights reserved.

ThemeData iTunesTheme() {
  return ThemeData(

    primaryColor: const Color(0xFF007AFF),

    secondaryHeaderColor: const Color(0xFFC7C7CC), 

    scaffoldBackgroundColor: Colors.white, 

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
      bodySmall: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007AFF), 
        foregroundColor: Colors.white, 
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color(0xFFF2F2F7), 
      hintStyle: const TextStyle(color: Colors.grey),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black87),
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFF007AFF), 
    ),


  );
}