import '../models/aula.dart';
import '../persistence/aula_dao.dart';


class LessonService {
  final Lesson_Dao _lessonDao = Lesson_Dao();

  Future<int> addLesson(Lesson lesson) async {
    return await _lessonDao.insertLesson(lesson);
  }

  Future<List<Lesson>> getLessons() async {
    return await _lessonDao.getAllLessons();
  }

  Future<int> updateLesson(Lesson lesson) async {
    return await _lessonDao.updateLesson(lesson);
  }

  Future<void> deleteLesson(int? id) async {
    return await _lessonDao.deleteLesson(id);
  }

}
