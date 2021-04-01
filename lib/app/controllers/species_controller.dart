import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/repository/species_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';
part 'species_controller.g.dart';

final _speciesRepository = SpeciesRepositiry();

class SpeciesController = _SpeciesControllerBase with _$SpeciesController;

abstract class _SpeciesControllerBase with Store {
  @observable
  Box<Specie> _speciesBox = Hive.box<Specie>(speciesBox);

  @observable
  List<Specie> species = [];

  @action
  getSpecies({String? nextPage}) async {
    setRes(false);
    if (_speciesBox.values.isNotEmpty && nextPage == null) {
      species = _speciesBox.values.toList();
      setRes(true);
    } else {
      species = [];
      species = await _speciesRepository.fecthSpecies(nextPage: nextPage);
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
  int specieSelected = 0;

  @action
  setSpecieSelected(int newValue) {
    specieSelected = newValue;
  }

  @computed
  List<Specie> get filterSpecies {
    if (searchText == '') {
      return species;
    } else {
      return species
          .where((specie) => Converters()
              .simplifyString(specie.name)
              .contains(Converters().simplifyString(searchText)))
          .toList();
    }
  }
}
