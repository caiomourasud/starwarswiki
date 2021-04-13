import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomThemes {
  get light => ThemeData(
      brightness: Brightness.light,
      accentColor: Colors.blue[700],
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: Colors.blue[700]));

  get dark => ThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.red[700],
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: CupertinoColors.black,
      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: Colors.red[700]));
}
