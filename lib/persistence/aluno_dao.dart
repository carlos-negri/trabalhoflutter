import '../core/database.dart';
import '../models/aluno.dart';

class Aluno_Dao {
  static const String table = 'alunos';

  Future<int> insertAluno(Aluno aluno) async {
    final db = await AppDatabase().database;
    return db.insert(table, aluno.toMap());
  }

  Future<List<Aluno>> getAllAlunos() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Aluno.fromMap(map)).toList();
  }

  Future<int> updateAluno(Aluno aluno) async {
    final db = await AppDatabase().database;
    return db.update(table, aluno.toMap(), where: 'id_aluno = ?', whereArgs: [aluno.id_aluno]);
  }

  Future<void> deleteAluno(int? idaluno) async {
    final db = await AppDatabase().database;
    await db.delete(table, where: 'id_aluno = ?', whereArgs: [idaluno]);
  }

}
