import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/app/models/people.dart';

import 'package:http/http.dart' as http;

part 'characters_controller.g.dart';

StorageUtil prefs = StorageUtil();

class CharactersController = _CharactersControllerBase
    with _$CharactersController;

abstract class _CharactersControllerBase with Store {
  @observable
  late ScrollController scrollController = ScrollController();

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
  double position = 0.0;

  @action
  setPosition(newValue) => position = newValue;

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
  setFavorito(int id) {
    var foundIndex = people.indexWhere((person) => person.id == id);
    people[foundIndex].isFavorite = !people[foundIndex].isFavorite;
    _peopleBox.putAt(foundIndex, people[foundIndex]);
  }

  @observable
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @observable
  People personSelected = People(
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
  setPersonSelected(newValue) {
    if (newValue != null) {
      personSelected = newValue;
    } else {
      personSelected = People(
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
    }
  }

  @action
  getPeople() async {
    clearPeopleBox();
    clearListPeople();
    setPersonSelected(null);
    setRes(false);
    String _url = 'https://swapi.dev/api/people/';
    var resposta = await http.get(Uri.parse(_url));
    var jsonData = jsonDecode(resposta.body);
    next = jsonData['next'].replaceAll('http', 'https');
    prefs.setString('next', next);
    Iterable films = jsonData['results'];
    films.map((person) {
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

  @action
  getMorePeople(String link) async {
    setRes(false);
    var resposta = await http.get(Uri.parse(link));
    var jsonData = jsonDecode(resposta.body);
    Iterable people = jsonData['results'];
    people.map((person) {
      addListPeople(People.fromJson(person));
      addPeopleBox(People.fromJson(person));
    }).toList();
    setRes(true);
    if (jsonData['next'] != null) {
      next = jsonData['next'].replaceAll('http', 'https');
      prefs.setString('next', next);
    } else {
      prefs.setString('next', '');
      next = '';
    }
    print(next);
    if (next != '' && res) getMorePeople(next);
  }

  @computed
  List<People> get filterCharacters {
    if (showFavorites) {
      var favoritos =
          people.where((personagem) => personagem.isFavorite).toList();
      if (searchText == '') {
        return favoritos;
      } else {
        return favoritos
            .where((character) => character.name
                .toLowerCase()
                .replaceAll('á', 'a')
                .replaceAll('é', 'e')
                .replaceAll('í', 'i')
                .replaceAll('ó', 'o')
                .replaceAll('ú', 'u')
                .replaceAll('ê', 'e')
                .replaceAll('ã', 'a')
                .replaceAll('õ', 'o')
                .replaceAll('ç', 'c')
                .contains(searchText
                    .toLowerCase()
                    .replaceAll('á', 'a')
                    .replaceAll('é', 'e')
                    .replaceAll('í', 'i')
                    .replaceAll('ó', 'o')
                    .replaceAll('ú', 'u')
                    .replaceAll('ê', 'e')
                    .replaceAll('ã', 'a')
                    .replaceAll('õ', 'o')
                    .replaceAll('ç', 'c')))
            .toList();
      }
    } else {
      if (searchText == '') {
        return people;
      } else {
        return people
            .where((character) => character.name
                .toLowerCase()
                .replaceAll('á', 'a')
                .replaceAll('é', 'e')
                .replaceAll('í', 'i')
                .replaceAll('ó', 'o')
                .replaceAll('ú', 'u')
                .replaceAll('ê', 'e')
                .replaceAll('ã', 'a')
                .replaceAll('õ', 'o')
                .replaceAll('ç', 'c')
                .contains(searchText
                    .toLowerCase()
                    .replaceAll('á', 'a')
                    .replaceAll('é', 'e')
                    .replaceAll('í', 'i')
                    .replaceAll('ó', 'o')
                    .replaceAll('ú', 'u')
                    .replaceAll('ê', 'e')
                    .replaceAll('ã', 'a')
                    .replaceAll('õ', 'o')
                    .replaceAll('ç', 'c')))
            .toList();
      }
    }
  }
}
