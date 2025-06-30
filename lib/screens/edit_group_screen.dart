import 'package:flutter/material.dart';
import '../models/turma.dart';
import '../service/turma_service.dart';

class EditGroupPage extends StatefulWidget {
  final Group group;
  const EditGroupPage({super.key, required this.group});

  @override
  _EditGroupPageState createState() => _EditGroupPageState();
}


class _EditGroupPageState extends State<EditGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final GroupService _groupService = GroupService();


  @override void initState() {
    super.initState();
    _groupNameController.text = widget.group.nomeTurma;
    _levelController.text = widget.group.nivel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar turma')),
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
                  _updateGroup();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateGroup() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedGroup = Group(
          id_turma: widget.group.id_turma,
          nomeTurma: _groupNameController.text,
          nivel: _levelController.text,
        );
        await _groupService.updateGroup(updatedGroup);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Turma atualizada com sucesso!')),
        );
  
        Navigator.of(context).pop(true);
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar turma: $e')),
        );
      }
    }
  }
}