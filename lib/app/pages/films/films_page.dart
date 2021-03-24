import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starwarswiki/app/pages/films/film_details/film_details_page.dart';
import 'package:starwarswiki/code/config.dart';
import 'package:starwarswiki/app/models/film.dart';

import 'package:http/http.dart' as http;

Box<Film> listFilmes = Hive.box<Film>(filmsBox);

class FilmsPage extends StatefulWidget {
  @override
  _FilmsPageState createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  @override
  void initState() {
    // listFilmes.clear();
    // getFilms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.person_add_solid),
        onPressed: () => setState(() {
          // listFilmes.clear();
        }),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: listFilmes.values
                .map((film) => ListTile(
                    title: Text(film.title),
                    subtitle: Text('${film.id}'),
                    onTap: () => Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return new FilmDetailsPage(film: film);
                        }))))
                .toList(),
          ),
        ),
      ),
    );
  }

  void getFilms() async {
    String _url = 'https://swapi.dev/api/films/';
    var resposta = await http.get(Uri.parse(_url));
    var jsonData = jsonDecode(resposta.body);
    Iterable films = jsonData['results'];
    if (listFilmes.values.isEmpty) {
      films.map((film) {
        listFilmes.add(Film.fromJson(film));
      }).toList();
    }
    setState(() {});
  }
}