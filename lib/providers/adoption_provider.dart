import 'package:flutter/material.dart';
import '../model/adoption.dart';
import '../model/adoption_dao.dart';

class AdoptionProvider extends ChangeNotifier {
  List<Adoption> get adoptions => _adoptions;

  void setAdoptions(List<Adoption> adoptions) {
    _adoptions = adoptions;
    notifyListeners();
  }

  List<Adoption> _adoptions = [];
  Future<List<Adoption>> getAllAdoptions() async {
    _adoptions = await AdoptionDAO.getAdoptions();
    return _adoptions;
  }

  Adoption? _adoption;

  Adoption? get adoption => _adoption;

  void setAdoption(Adoption? adoption) {
    _adoption = adoption;
    notifyListeners();
  }

  void clear() {
    _adoption = null;
    notifyListeners();
  }
}
