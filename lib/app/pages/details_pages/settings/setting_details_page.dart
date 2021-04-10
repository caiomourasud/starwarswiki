import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'content/appearance_content.dart';

class SettingDetailsPage extends StatefulWidget {
  final String title;

  const SettingDetailsPage({Key? key, required this.title}) : super(key: key);
  @override
  _SettingDetailsPageState createState() => _SettingDetailsPageState();
}

class _SettingDetailsPageState extends State<SettingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CupertinoNavigationBar(
          automaticallyImplyLeading: width <= md,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          transitionBetweenRoutes: width <= md,
          middle: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black87
                        : Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
          trailing: SizedBox(width: 30.0),
          border: Border.all(color: Colors.transparent)),
      body: AppearanceContent(),
    );
  }
}
