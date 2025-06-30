import 'package:flutter/material.dart';

class AttendanceControlScreen extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {'name': 'Alberto Gonzalez', 'faults': 1},
    {'name': 'Barnabé Souza', 'faults': 2},
    {'name': 'Cristóvão Colombo', 'faults': 3},
    {'name': 'Dilma Rousseff', 'faults': 4},
    {'name': 'Edgardo Hernandez', 'faults': 5},
    {'name': 'Fátima Bernardes', 'faults': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Frequência'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar aluno',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: student['faults'] >= 5 ? Colors.red[100] : null,
                  child: ListTile(
                    title: Text(student['name']),
                    subtitle: Text('Faltas: ${student['faults']}'),
                    trailing: student['faults'] >= 5
                        ? Icon(Icons.warning, color: Colors.red)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}