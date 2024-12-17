import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart'; // Import the homepage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Blue theme
        useMaterial3: false, // Disable Material 3 for classic style
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // AppBar background color
          foregroundColor: Colors.white, // Text/icon color in AppBar
        ),
      ),
      home: const HomePage(), // Set HomePage as the first screen
    );
  }
}
