import 'package:chamada/service/turma_service.dart';
import 'package:flutter/material.dart';
import '../models/aluno.dart';
import '../models/turma.dart';
import '../service/aluno_service.dart';


class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final GroupService _groupService = GroupService();
  late Future<List<Group>> _groupsFuture;
  Group? _selectedGroup;
  List<Group> _groups = [];

  @override
  void initState(){
    super.initState();
    _groupsFuture = _groupService.getGroups();
  }



  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupNameController = TextEditingController();
  final AlunoService _AlunoService = AlunoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar aluno')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FutureBuilder<List<Group>>(
            future: _groupsFuture,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              }

              final groups = snapshot.data ?? [];
              return ListView(

                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nome do Aluno'),
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
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
                    validator: (value) => value == null ? 'De que turma o aluno faz parte?' : null,
                  ),
                ElevatedButton(
                  onPressed: _saveStudent,
                  child: const Text('Salvar'),
                ),
              ] ,
            );
            },
          ),
        ),
      ),
    );
  }

  void _saveStudent() async {
    if (_formKey.currentState!.validate() && _selectedGroup != null) {
      try {
        final student = Aluno(
          nome: _nameController.text,
          id_turma: _selectedGroup!.id_turma,
          nomeTurma: _selectedGroup!.nomeTurma,
        );

        await _AlunoService.addAluno(student);


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aluno registrado com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    }
  }
}