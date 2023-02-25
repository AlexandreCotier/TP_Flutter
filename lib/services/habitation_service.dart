import 'package:location/models/habitat.dart';
import 'package:location/models/habitation.dart';

import '../models/typehabitat_data.dart';
import '../models/habitations_data.dart';

class HabitationService {
  var _typeHabitats;
  var _habitations;

  HabitationService() {
    _typeHabitats = TypehabitatData.buildList();
    _habitations = HabitationsData.buildList();
  }

  List<TypeHabitat> getTypeHabitats(){
    return _typeHabitats;
  }

  List<Habitation> getHabitationsTop10(){
    return _habitations
        .where((element) => element.id%2 == 1)
        .take(10)
        .toList();
  }

  List<Habitation> getMaisons(){
    return _getHabitations(isHouse: true);
  }

  List<Habitation> _getHabitations({bool isHouse = true}){
    return _habitations
        .where((element) => element.typeHabitat.id == (isHouse ? 1 : 2))
        .toList();
  }

  List<Habitation> getAppartements(){
    return _getHabitations(isHouse: false);
  }

  Habitation getHabitationById(int id){
    return _habitations.firstWhere((element) => element.id == id);
  }
}