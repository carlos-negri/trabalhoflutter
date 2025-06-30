import 'package:chamada/screens/edit_student_screen.dart';
import 'package:chamada/screens/register_student_screen.dart';
import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../service/aluno_service.dart';

class MyStudents extends StatefulWidget {
  const MyStudents({super.key});

  @override
  _MyStudentsState createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  final AlunoService _alunoService = AlunoService();
  late Future<List<Aluno>> _alunos;

  @override
  void initState() {
    super.initState();
    _alunos = _alunoService.getAlunos();
  }

  void _refreshStudents() {
    setState(() {
      _alunos = _alunoService.getAlunos();
    });
  }

  void _confirmDelete(int? idAluno) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir este aluno?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _alunoService.deleteAluno(idAluno);
              _refreshStudents();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Aluno excluído com sucesso!')),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus alunos')),
      body: FutureBuilder<List<Aluno>>(
        future: _alunos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum aluno encontrado.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final aluno = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      aluno.nome.isNotEmpty ? aluno.nome[0].toUpperCase() : '?',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                  title: Text(
                    aluno.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  subtitle: Text(
                    aluno.nomeTurma,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudentPage(aluno: aluno),
                            ),
                          );
                          if (updated == true) {
                            _refreshStudents();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _confirmDelete(aluno.id_aluno),
                        tooltip: 'Excluir aluno',
                      ),
                    ]

                  )
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudentPage()),
          );
          _refreshStudents();
        },
        child: const Icon(Icons.add),
        tooltip: 'Adicionar aluno',
      ),
    );
  }
}
