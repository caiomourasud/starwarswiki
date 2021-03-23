import 'package:flutter/material.dart';
import 'package:starwarswiki/db/film_table.dart';

class FilmDetailsPage extends StatefulWidget {
  final FilmTable film;

  const FilmDetailsPage({Key? key, required this.film}) : super(key: key);
  @override
  _FilmDetailsPageState createState() => _FilmDetailsPageState();
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film.title),
      ),
    );
  }
}
