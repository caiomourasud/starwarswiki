import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class CharacterDetailsPage extends StatefulWidget {
  final People character;

  const CharacterDetailsPage({Key? key, required this.character})
      : super(key: key);
  @override
  _CharacterDetailsPageState createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md,
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.character.name,
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
