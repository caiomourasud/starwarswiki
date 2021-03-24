import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/planet.dart';

class PlanetDetailsPage extends StatefulWidget {
  final Planet planet;

  const PlanetDetailsPage({Key? key, required this.planet}) : super(key: key);
  @override
  _PlanetDetailsPageState createState() => _PlanetDetailsPageState();
}

class _PlanetDetailsPageState extends State<PlanetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.planet.name,
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
