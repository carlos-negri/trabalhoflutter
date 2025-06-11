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
}
