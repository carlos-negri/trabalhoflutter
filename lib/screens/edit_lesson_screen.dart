import 'package:chamada/service/turma_service.dart';
import 'package:flutter/material.dart';
import '../models/aula.dart';
import '../models/turma.dart';
import '../service/aula_service.dart';

class EditLessonPage extends StatefulWidget {
  final Lesson lesson;
  const EditLessonPage({super.key, required this.lesson});

  @override
  _EditLessonPageState createState() => _EditLessonPageState();
}

class _EditLessonPageState extends State<EditLessonPage> {
  final GroupService _groupService = GroupService();
  final LessonService _lessonService = LessonService();
  final _formKey = GlobalKey<FormState>();
  late Future<List<Group>> _groupsFuture;

  Group? _selectedGroup;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _groupsFuture = _groupService.getGroups();
    _dateController.text = widget.lesson.lessonDate;
    _timeController.text = widget.lesson.lessonTime;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar aula')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FutureBuilder<List<Group>>(
            future: _groupsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              }

              final groups = snapshot.data ?? [];



              if (_selectedGroup == null && groups.isNotEmpty) {
                _selectedGroup = groups.firstWhere(
                      (g) => g.id_turma == widget.lesson.id_turma,
                  orElse: () => groups.first,
                );
              }

              return ListView(
                children: [
                  DropdownButtonFormField<Group>(
                    value: _selectedGroup,
                    items: groups.map((Group group) {
                      return DropdownMenuItem<Group>(
                        value: group,
                        child: Text(group.nomeTurma),
                      );
                    }).toList(),
                    onChanged: (Group? newValue) {
                      setState(() {
                        _selectedGroup = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Turma',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null ? 'Selecione uma turma' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Data',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'Hora',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    child: const Text('Salvar Aula'),
                    onPressed: _saveLesson,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _saveLesson() async {
    if (_formKey.currentState!.validate() && _selectedGroup != null) {
      try {
        final updatedLesson = Lesson(
          id_aula: widget.lesson.id_aula,
          id_turma: _selectedGroup!.id_turma,
          lessonTime: _timeController.text,
          lessonDate: _dateController.text,
        );

        await _lessonService.updateLesson(updatedLesson);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aula atualizada com sucesso!')),
        );

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar: $e')),
        );
      }
    }
  }
}
