import 'package:flutter/material.dart';

class SettingList {
  final int id;
  final String title;
  final String subtitle;
  final Widget trailing;

  SettingList(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.trailing});
}
