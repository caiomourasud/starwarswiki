import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultView extends StatelessWidget {
  final Widget page;
  final List<Widget> actionList;
  final GlobalKey<NavigatorState>? navigatorKey;
  const DefaultView(
      {required this.page, required this.actionList, this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return CupertinoPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return page;
          },
        );
      },
    );
  }
}
