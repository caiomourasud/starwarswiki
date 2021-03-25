import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class FilmDetailsPage extends StatefulWidget {
  final Film film;

  const FilmDetailsPage({Key? key, required this.film}) : super(key: key);
  @override
  _FilmDetailsPageState createState() => _FilmDetailsPageState();
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md,
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.film.title,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Container(),
    );
  }
}
