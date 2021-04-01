import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/repository/planets_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';
part 'planets_controller.g.dart';

final _planetsRepository = PlanetsRepositiry();

class PlanetsController = _PlanetsControllerBase with _$PlanetsController;

abstract class _PlanetsControllerBase with Store {
  @observable
  Box<Planet> _planetsBox = Hive.box<Planet>(planetsBox);

  @observable
  List<Planet> planets = [];

  @action
  getPlanets({String? nextPage}) async {
    setRes(false);
    if (_planetsBox.values.isNotEmpty && nextPage == null) {
      planets = _planetsBox.values.toList();
      setRes(true);
    } else {
      planets = [];
      planets = await _planetsRepository.fecthPlanets(nextPage: nextPage);
      setRes(true);
    }
  }

  @observable
  bool res = true;

  @action
  setRes(newValue) => res = newValue;

  @observable
  String searchText = '';

  @action
  setSearchText(newValue) => searchText = newValue;

  @observable
  int planetSelected = 0;

  @action
  setPlanetSelected(int newValue) {
    planetSelected = newValue;
  }

  @computed
  List<Planet> get filterPlanets {
    if (searchText == '') {
      return planets;
    } else {
      return planets
          .where((planet) => Converters()
              .simplifyString(planet.name)
              .contains(Converters().simplifyString(searchText)))
          .toList();
    }
  }
}
