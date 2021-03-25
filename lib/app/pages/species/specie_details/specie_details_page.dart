import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class SpecieDetailsPage extends StatefulWidget {
  final Specie specie;

  const SpecieDetailsPage({Key? key, required this.specie}) : super(key: key);
  @override
  _SpecieDetailsPageState createState() => _SpecieDetailsPageState();
}

class _SpecieDetailsPageState extends State<SpecieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md,
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.specie.name,
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
