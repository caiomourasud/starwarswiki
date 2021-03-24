import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/starship.dart';

class StarshipDetailsPage extends StatefulWidget {
  final Starship starship;

  const StarshipDetailsPage({Key? key, required this.starship})
      : super(key: key);
  @override
  _StarshipDetailsPageState createState() => _StarshipDetailsPageState();
}

class _StarshipDetailsPageState extends State<StarshipDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.starship.name,
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
