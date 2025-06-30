class Lesson {
  final int? id_aula;
  final int? id_turma;
  final String lessonDate;
  final String lessonTime;



  Lesson({
    this.id_aula,
    required this.lessonDate,
    required this.lessonTime,
    required this.id_turma,

  });

  Map<String, dynamic> toMap() {
    return {
      'id_aula': id_aula,
      'id_turma': id_turma,
      'lessonTime': lessonTime,
      'lessonDate': lessonDate,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id_aula: map['id_aula'],
      id_turma: map['id_turma'],
      lessonTime: map['lessonTime'],
      lessonDate: map['lessonDate'],

    );
  }
}
