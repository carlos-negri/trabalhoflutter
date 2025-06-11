import 'package:chamada/screens/edit_group_screen.dart';
import 'package:chamada/screens/register_group_screen.dart';
import 'package:flutter/material.dart';
import '../models/turma.dart';
import '../service/turma_service.dart';

class MyGroups extends StatefulWidget {
  const MyGroups ({super.key});

  @override
  _MyGroupsState createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups>{
  final GroupService _groupService = GroupService();
  late Future<List<Group>> _groups;

  @override
  void initState(){
    super.initState();
    _groups = _groupService.getGroups();
  }

  void _refreshGroups(){
    setState(() {
      _groups=_groupService.getGroups();
    });
  }


  void _confirmDelete(int? idturma) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir esta turma?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _groupService.deleteGroup(idturma);
              _refreshGroups();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Turma excluída com sucesso!')),
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
      appBar: AppBar(title: Text('Minhas turmas')),
      body: FutureBuilder<List<Group>>(
        future: _groups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma turma encontrada.'));
          }
          return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (context, index) {
    final group = snapshot.data![index];
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(group.nomeTurma.substring(0,1)),
        ),
        title: Text(group.nomeTurma, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Nível: ${group.nivel}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditGroupPage(group: group),
                  ),
                );
                if (updated == true) {
                  _refreshGroups();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDelete(group.id_turma),
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
            MaterialPageRoute(builder: (context) => AddGroupPage()),
          );
          _refreshGroups();
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}