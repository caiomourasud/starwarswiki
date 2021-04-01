import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/app/models/people.dart';

part 'characters_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class CharactersController = _CharactersControllerBase
    with _$CharactersController;

abstract class _CharactersControllerBase with Store {
  @observable
  Box<People> _peopleBox = Hive.box<People>(peopleBox);

  @observable
  List<People> people = [];

  @action
  peopleFromDB() {
    people = _peopleBox.values.toList();
  }

  @action
  addListPeople(newValue) => people.add(newValue);

  @action
  addPeopleBox(newValue) => _peopleBox.add(newValue);

  @action
  clearListPeople() => people.clear();

  @action
  clearPeopleBox() => _peopleBox.clear();

  @action
  deletePeopleBox() => _peopleBox.deleteFromDisk();

  @observable
  bool res = true;

  @action
  setRes(newValue) => res = newValue;

  @observable
  String searchText = '';

  @action
  setSearchText(newValue) => searchText = newValue;

  @observable
  String next = '';

  @action
  setNext(newValue) => next = newValue;

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

  @action
  setFavorite(int id) {
    var foundIndex = people.indexWhere((person) => person.id == id);
    people[foundIndex].isFavorite = !people[foundIndex].isFavorite;
    _peopleBox.putAt(foundIndex, people[foundIndex]);
  }

  @observable
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @action
  personById(int id) {
    if (id == 0) {
      return null;
    } else {
      var person = people.where((person) => person.id == id);
      return person.first;
    }
  }

  @observable
  int personSelected = 0;

  @action
  setPersonSelected(int newValue) {
    personSelected = newValue;
  }

  API? api;

  @action
  getPeople() async {
    clearPeopleBox();
    clearListPeople();
    setPersonSelected(0);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi('https://swapi.dev/api/people/', successGetPeople, error,
        _appController.context!);
  }

  @action
  getMorePeople(String link) async {
    setRes(false);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi(link, successGetMorePeople, error, _appController.context!);
  }

  successGetPeople(jsonData) async {
    if (jsonData != null) {
      next = jsonData['next'].replaceAll('http', 'https');
      _prefs.setString('next_people', next);
      Iterable peple = jsonData['results'];
      peple.map((person) {
        addListPeople(People.fromJson(person));
        addPeopleBox(People.fromJson(person));
      }).toList();
      print(next);
      setRes(true);
      if (res) {
        Timer(Duration(milliseconds: 200), () {
          if (res) getMorePeople(next);
        });
      }
    }
  }

  successGetMorePeople(jsonData) async {
    if (jsonData != null) {
      Iterable people = jsonData['results'];
      people.map((person) {
        addListPeople(People.fromJson(person));
        addPeopleBox(People.fromJson(person));
      }).toList();
      setRes(true);
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_people', next);
      } else {
        _prefs.setString('next_people', '');
        next = '';
      }
      print(next);
      if (next != '' && res) getMorePeople(next);
    }
  }

  error(jsonData) {
    setRes(true);
    if (jsonData != null) {
      print('error');
      // alert.alertDialog(
      //     context: context,
      //     titulo: 'Atenção',
      //     subtitulo: jsonData,
      //     secundario: 'OK',
      //     cor: Colors.red);
    }
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
