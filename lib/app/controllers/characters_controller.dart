import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/repository/characters_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/app/models/people.dart';

part 'characters_controller.g.dart';

final _charactersRepository = CharactersRepositiry();

class CharactersController = _CharactersControllerBase
    with _$CharactersController;

abstract class _CharactersControllerBase with Store {
  @observable
  Box<People> _peopleBox = Hive.box<People>(peopleBox);

  @observable
  List<People> people = [];

  @action
  getPeople({String? nextPage}) async {
    setRes(false);
    if (_peopleBox.values.isNotEmpty && nextPage == null) {
      people = _peopleBox.values.toList();
      setRes(true);
    } else {
      people = [];
      people = await _charactersRepository.fecthCharacters(nextPage: nextPage);
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
  bool showFavorites = false;

  @action
  setShowFavorites(newValue) {
    if (newValue == null) {
      showFavorites = !showFavorites;
    } else {
      showFavorites = newValue;
    }
  }

  @observable
  int personSelected = 0;

  @action
  setPersonSelected(int newValue) {
    personSelected = newValue;
  }

  @computed
  List<People> get filterCharacters {
    if (showFavorites) {
      var favorites =
          people.where((personagem) => personagem.isFavorite).toList();
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((character) => Converters()
                .simplifyString(character.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    } else {
      if (searchText == '') {
        return people;
      } else {
        return people
            .where((character) => Converters()
                .simplifyString(character.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    }
  }
}
