import 'package:flutter/material.dart';
import '../models/turma.dart';
import '../service/turma_service.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({super.key});

  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final GroupService _groupService = GroupService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar turma')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _groupNameController,
                decoration: const InputDecoration(labelText: 'Nome da turma'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _levelController,
                decoration: const InputDecoration(labelText: 'Nível'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              ElevatedButton(
                onPressed: (){
                  _saveGroup();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveGroup() async {
    if (_formKey.currentState!.validate()) {
      try {
        final group = Group(
          nomeTurma: _groupNameController.text,
          nivel: _levelController.text,
        );
        await _groupService.addGroup(group);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Turma salva com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar turma: $e')),
        );
      }
    }
  }
}