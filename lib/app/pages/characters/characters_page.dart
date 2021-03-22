import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/db/people_table.dart';

Box<PeopleTable> listPeople = Hive.box<PeopleTable>(peopleBox);

bool res = true;
String? next;

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    listPeople.clear();
    getPeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.person_add_solid),
        onPressed: () => setState(() {}),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: listPeople.values
                .map((person) => ListTile(
                    title: Text(person.name),
                    subtitle: Text('${person.id}'),
                    onTap: () {}))
                .toList(),
          ),
        ),
      ),
    );
  }

  void getPeople() async {
    res = false;
    String _url = 'https://swapi.dev/api/people/';
    var resposta = await http.get(Uri.parse(_url));
    var jsonData = jsonDecode(resposta.body);
    next = jsonData['next'].replaceAll('http', 'https');
    Iterable films = jsonData['results'];
    if (listPeople.values.isEmpty) {
      films.map((person) {
        listPeople.add(PeopleTable.fromJson(person));
      }).toList();
    }
    res = true;
    if (res) getMorePeople(next!);
  }

  void getMorePeople(String link) async {
    res = false;
    var resposta = await http.get(Uri.parse(link));
    var jsonData = jsonDecode(resposta.body);
    Iterable films = jsonData['results'];
    films.map((person) {
      listPeople.add(PeopleTable.fromJson(person));
    }).toList();
    res = true;
    if (jsonData['next'] != null) {
      next = jsonData['next'].replaceAll('http', 'https');
    } else {
      next = null;
    }
    if (next != null) getMorePeople(next!);
  }
}
