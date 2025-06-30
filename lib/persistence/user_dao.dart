import '../models/user.dart';
import '../core/database.dart';

class UserDao {
  static const String table = 'users';

  Future<int> insertUser(User user) async {
    final db = await AppDatabase().database;
    return db.insert(table, user.toMap());
  }

  Future<User?> getUser(String email, String password) async {
    final db = await AppDatabase().database;
    final result = await db.query(
      table,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  Future<User?> getUserById(int id) async {
    final db = await AppDatabase().database;
    final result = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

  Future<int> updateUser(User user) async {
    final db = await AppDatabase().database;
    return db.update(
      table,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

}
