import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/code/breakpoints.dart';

var heroTag = 'settings';

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class SettingDetailsPage extends StatefulWidget {
  final String title;

  const SettingDetailsPage({Key? key, required this.title}) : super(key: key);
  @override
  _SettingDetailsPageState createState() => _SettingDetailsPageState();
}

class _SettingDetailsPageState extends State<SettingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.title,
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
