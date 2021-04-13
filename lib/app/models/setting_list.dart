import 'package:flutter/material.dart';

class SettingList {
  final int id;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final Widget page;

  SettingList(
      {required this.id,
      required this.title,
      this.subtitle,
      required this.trailing,
      required this.page});
}
