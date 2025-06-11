import 'package:chamada/models/aula.dart';
import 'package:chamada/screens/register_class_screen.dart';
import 'package:chamada/service/aula_service.dart';
import 'package:flutter/material.dart';

class MyLessons extends StatefulWidget {
  const MyLessons ({super.key});

  @override
  _MyLessonsState createState() => _MyLessonsState();
}

class _MyLessonsState extends State<MyLessons>{
  final LessonService _lessonService = LessonService();
  late Future<List<Lesson>> _lessons;

  @override
  void initState(){
    super.initState();
    _lessons = _lessonService.getLessons();
  }

  void _refreshLessons(){
    setState(() {
      _lessons=_lessonService.getLessons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas aulas')),
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
              return ListTile(
                title: Text(lesson.lessonDate),
                subtitle: Text(lesson.lessonTime),
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