import 'package:chamada/screens/my_groups_screen.dart';
import 'package:chamada/screens/my_students.dart';
import 'package:chamada/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'home_screen.dart';
import 'my_lessons_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MyLessons(),
    MyStudents(),
    MyGroups(),
    AttendanceControlScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF7F41),
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Aulas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Alunos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Turmas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Frequência',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),

    );
  }
}