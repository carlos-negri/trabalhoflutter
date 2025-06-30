import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() => _instance;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'school.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE turmas(
            id_turma INTEGER PRIMARY KEY AUTOINCREMENT,
            nomeTurma TEXT,
            nivel TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE alunos(
            id_aluno INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            id_turma INTEGER,
            nomeTurma TEXT,
            FOREIGN KEY (id_turma) REFERENCES turmas (id_turma)
            FOREIGN KEY (nomeTurma) REFERENCES turmas (nomeTurma)
          )
        ''');
        await db.execute('''
          CREATE TABLE lessons(
            id_aula INTEGER PRIMARY KEY AUTOINCREMENT,
            lessonTime TEXT,
            lessonDate TEXT,
            id_turma INTEGER,
            FOREIGN KEY (id_turma) REFERENCES turmas (id_turma)
          )
        ''');
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            password TEXT,
            imagemPath TEXT
          )
        ''');

      },
    );
  }
}
