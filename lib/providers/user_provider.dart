import 'package:flutter/material.dart';
import 'package:pet_match/model/user_dao.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  Future<void> updateUser(User user) async {
    await UserDAO.atualizar(user);
    setUser(user);
  }

  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
