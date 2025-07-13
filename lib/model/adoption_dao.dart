import 'package:pet_match/database/db_helper.dart';
import 'package:pet_match/model/adoption.dart';

class AdoptionDAO {
  static Future<int> countAdoptionsByUser(int userId) async {
    var db = await DBHelper.getInstance();
    final result = await db.query(
      'adoptions',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.length;
  }

  static Future<List<Adoption>> getAdoptions() async {
    var db = await DBHelper.getInstance();
    final result = await db.query('adoptions');
    return result.map((adoption) => Adoption.fromMap(adoption)).toList();
  }

  static Future<void> inserir(Adoption adoption) async {
    var db = await DBHelper.getInstance();
    await db.insert('adoptions', adoption.toMap());
  }

  static Future<void> deletar(int id) async {
    var db = await DBHelper.getInstance();
    await db.delete('adoptions', where: 'id = ?', whereArgs: [id]);
  }
}
