import '../core/database.dart';
import '../models/aula.dart';

class Lesson_Dao {
  static const String table = 'lessons';

  Future<int> insertLesson(Lesson lesson) async {
    final db = await AppDatabase().database;
    return db.insert(table, lesson.toMap());
  }

  Future<List<Lesson>> getAllLessons() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Lesson.fromMap(map)).toList();
  }

  Future<int> updateLesson(Lesson lesson) async {
    final db = await AppDatabase().database;
    return db.update(table, lesson.toMap(), where: 'id_aula = ?', whereArgs: [lesson.id_aula]);
  }

  Future<void> deleteLesson(int? idaula) async {
    final db = await AppDatabase().database;
    await db.delete(table, where: 'id_aula = ?', whereArgs: [idaula]);
  }

}
