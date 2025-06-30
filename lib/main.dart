import 'package:chamada/screens/my_lessons_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'core/database.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase().database;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chamada Certa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // PERSONALIZAÇÃO:
        primaryColor: const Color(0xFF2E5EAA),
        colorScheme: ColorScheme.light(
          secondary: const Color(0xFFFF7F41),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1A3A6F),
          elevation: 4,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFFFF7F41),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          labelStyle: TextStyle(color: Color(0xFF2E5EAA)),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      home: LoginPage(),
      routes: {
        '/main': (context) => MainScreen(),
      },
    );
  }
}