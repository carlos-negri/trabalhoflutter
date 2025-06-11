import '../core/database.dart';
import '../models/turma.dart';

class Group_Dao {
  static const String table = 'turmas';

  Future<int> insertGroup(Group group) async {
    final db = await AppDatabase().database;
    return db.insert(table, group.toMap());
  }

  Future<List<Group>> getAllGroups() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Group.fromMap(map)).toList();
  }

  Future<int> updateGroup(Group group) async {
    final db = await AppDatabase().database;
    return db.update(table, group.toMap(), where: 'id_turma = ?', whereArgs: [group.id_turma]);
  }

  Future<void> deleteGroup(int? idturma) async {
    final db = await AppDatabase().database;
    await db.delete(table, where: 'id_turma = ?', whereArgs: [idturma]);
  }


}
