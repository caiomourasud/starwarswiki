import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/db/people_table.dart';

part 'characters_controller.g.dart';

class CharactersController = _CharactersControllerBase
    with _$CharactersController;

abstract class _CharactersControllerBase with Store {
  @observable
  Box<PeopleTable> _listPeople = Hive.box<PeopleTable>(peopleBox);

  @computed
  get listPeople => _listPeople.values;

  @action
  addListPeople(newValue) => _listPeople.add(newValue);

  @action
  clearListPeople() => _listPeople.clear();

  @observable
  bool res = true;

  @action
  setRes(newValue) => res = newValue;

  @observable
  String next = '';

  @action
  setNext(newValue) => next = newValue;

  @observable
  double position = 0.0;

  @action
  setPosition(newValue) => position = newValue;

  @observable
  bool showFavorites = false;

  @action
  setFavorites(newValue) {
    if (newValue == null) {
      showFavorites = !showFavorites;
    } else {
      showFavorites = newValue;
    }
  }

  @observable
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @observable
  PeopleTable personSelected = PeopleTable(
      id: 0,
      name: '',
      height: '',
      mass: '',
      hairColor: '',
      skinColor: '',
      eyeColor: '',
      birthYear: '',
      gender: '',
      homeworld: '',
      films: [],
      species: [],
      vehicles: [],
      starships: [],
      created: '',
      edited: '',
      url: '');

  @action
  setPersonSelected(newValue) => personSelected = newValue;
}
