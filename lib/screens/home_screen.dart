import 'package:flutter/material.dart';
import 'my_students.dart';
import 'my_lessons_screen.dart';
import 'my_groups_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chamada Certa')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHomeButton(
              context,
              icon: Icons.school,
              label: 'Meus Alunos',
              color: Colors.blueAccent,
              destination: const MyStudents(),
            ),
            const SizedBox(height: 20),
            _buildHomeButton(
              context,
              icon: Icons.class_,
              label: 'Minhas Aulas',
              color: Colors.green,
              destination: const MyLessons(),
            ),
            const SizedBox(height: 20),
            _buildHomeButton(
              context,
              icon: Icons.group,
              label: 'Minhas Turmas',
              color: Colors.deepPurple,
              destination: const MyGroups(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context,
      {required IconData icon,
        required String label,
        required Color color,
        required Widget destination}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
        shadowColor: color.withOpacity(0.5),
      ),
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
