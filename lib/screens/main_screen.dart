import 'package:chamada/screens/my_groups_screen.dart';
import 'package:chamada/screens/my_students.dart';
import 'package:chamada/screens/profile_screen.dart';
import 'package:chamada/screens/register_class_screen.dart';
import 'package:flutter/material.dart';
import 'attendance_screen.dart';
import 'my_lessons_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MyLessons(),
    MyStudents(),
    MyGroups(),
    AttendanceControlScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chamada Certa'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFFFF7F41),
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Minhas aulas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Meus alunos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Minhas turmas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_rounded  ),
            label: 'Frequência',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Eu',
          ),
        ],
      ),
    );
  }
}