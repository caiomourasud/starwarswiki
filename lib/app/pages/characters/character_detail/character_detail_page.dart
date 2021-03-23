import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/db/people_table.dart';

class CharacterDetailPage extends StatefulWidget {
  final PeopleTable character;

  const CharacterDetailPage({Key? key, required this.character})
      : super(key: key);
  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
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
      child: Container(),
    );
  }
}
