import 'package:chamada/models/aula.dart';
import 'package:chamada/screens/register_class_screen.dart';
import 'package:chamada/screens/edit_lesson_screen.dart';
import 'package:chamada/service/aula_service.dart';
import 'package:chamada/service/turma_service.dart';
import 'package:flutter/material.dart';

import '../models/turma.dart';

class MyLessons extends StatefulWidget {
  const MyLessons({super.key});

  @override
  _MyLessonsState createState() => _MyLessonsState();
}

class _MyLessonsState extends State<MyLessons> {
  final LessonService _lessonService = LessonService();
  final GroupService _groupService = GroupService();
  late Future<List<Lesson>> _lessons;
  late Future<List<Group>> _groups;

  @override
  void initState() {
    super.initState();
    _lessons = _lessonService.getLessons();
    _groups = _groupService.getGroups();
  }

  void _refreshLessons() {
    setState(() {
      _lessons = _lessonService.getLessons();
    });
  }

  void _confirmDelete(int? idAula) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir esta aula?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _lessonService.deleteLesson(idAula);
              _refreshLessons();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Aula excluída com sucesso!')),
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
      appBar: AppBar(title: const Text('Minhas aulas')),
      body: FutureBuilder<List<Lesson>>(
        future: _lessons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma aula registrada.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final lesson = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green[100],
                    child: Text(lesson.lessonDate.substring(0, 1)),
                  ),
                  title: FutureBuilder<List<Group>>(
                    future: _groups,
                    builder: (context, groupSnapshot) {
                      if (!groupSnapshot.hasData) {
                        return const Text('Carregando turma...');
                      }
                      final groups = groupSnapshot.data!;
                      final turma = groups.firstWhere(
                            (g) => g.id_turma == lesson.id_turma,
                        orElse: () => Group(id_turma: 0, nomeTurma: 'Turma não encontrada', nivel: ''),
                      );
                      return Text(
                        'Turma: ${turma.nomeTurma}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Horário: ${lesson.lessonTime}"),
                      Text("Data: ${lesson.lessonDate}"),
                    ],
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
                              builder: (context) => EditLessonPage(lesson: lesson),
                            ),
                          );
                          if (updated == true) {
                            _refreshLessons();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(lesson.id_aula),
                      ),
                    ],
                  ),
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
            MaterialPageRoute(builder: (context) => AddLessonPage()),
          );
          _refreshLessons();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
