
import 'package:chamada/screens/register_student_screen.dart';
import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../service/aluno_service.dart';

class MyStudents extends StatefulWidget {
  const MyStudents ({super.key});

  @override
  _MyStudentsState createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents>{
  final AlunoService _alunoService = AlunoService();
  late Future<List<Aluno>> _alunos;

  @override
  void initState(){
    super.initState();
    _alunos = _alunoService.getAlunos();
  }

  void _refreshStudents(){
    setState(() {
      _alunos=_alunoService.getAlunos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus alunos')),
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
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final aluno = snapshot.data![index];
              return ListTile(
                title: Text(aluno.nome),
                subtitle: Text(aluno.nomeTurma),
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
      ),
    );
  }
}