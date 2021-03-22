import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/db/film_table.dart';

import 'package:http/http.dart' as http;

Box<FilmTable> listFilmes = Hive.box<FilmTable>(filmsBox);

class FilmsPage extends StatefulWidget {
  @override
  _FilmsPageState createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  @override
  Widget build(BuildContext context) {
    listFilmes.clear();
    getFilms();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.person_add_solid),
        onPressed: () => setState(() {
          // listFilmes.clear();
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: listFilmes.values
              .map((film) => ListTile(
                  title: Text(film.title),
                  subtitle: Text('${film.id}'),
                  onTap: () {}))
              .toList(),
        ),
      ),
    );
  }
}

void getFilms() async {
  String _url = 'https://swapi.dev/api/films/';
  var resposta = await http.get(Uri.parse(_url));
  var jsonData = jsonDecode(resposta.body);
  Iterable films = jsonData['results'];
  if (listFilmes.values.isEmpty) {
    films.map((film) {
      listFilmes.add(FilmTable.fromJson(film));
    }).toList();
  }
}
