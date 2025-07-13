import 'package:pet_match/database/db_helper.dart';
import 'package:pet_match/model/user.dart';

class UserDAO {
  static Future<User?> buscarPorId(int id) async {
    var db = await DBHelper.getInstance();
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first as Map<String, dynamic>);
    }
    return null;
  }

  static Future<int> inserir(User user) async {
    var db = await DBHelper.getInstance();
    return await db.insert('users', user.toMap());
  }

  static Future<void> atualizar(User user) async {
    var db = await DBHelper.getInstance();
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<void> deletar(User user) async {
    var db = await DBHelper.getInstance();
    await db.delete('users', where: 'id = ?', whereArgs: [user.id]);
  }

  static Future<List<User>> carregarUsuarios() async {
    var db = await DBHelper.getInstance();
    List<Map> result = await db.query('users');
    return result.map((e) => User.fromMap(e as Map<String, dynamic>)).toList();
  }

  static Future<User?> buscarPorEmailSenha(
    String email,
    String password,
  ) async {
    var db = await DBHelper.getInstance();
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first as Map<String, dynamic>);
    }
    return null;
  }
}
