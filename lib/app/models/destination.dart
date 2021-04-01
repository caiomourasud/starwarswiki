import 'package:flutter/material.dart';

class Destination {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget pagina;
  final IconData icon;
  final String tooltip;
  const Destination(
      {required this.navigatorKey,
      required this.pagina,
      required this.icon,
      required this.tooltip});
}
