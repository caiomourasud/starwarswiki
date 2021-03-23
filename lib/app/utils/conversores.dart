import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Conversores {
  toDouble(string, tipo) {
    //0 = kg; 1 = m;
    if (string != null) {
      if (string != 'unknown') {
        string = string.replaceAll(',', '');
        return '${double.parse(string) / (tipo == 1 ? 100 : 1)}${tipo == 1 ? 'm' : 'kg'}';
      } else {
        return 'Desconhecido';
      }
    } else {
      return 'Desconhecido';
    }
  }

  setGender(gender, iconSize) {
    switch (gender) {
      case 'male':
        return Icon(FontAwesomeIcons.mars,
            size: iconSize, color: Colors.blue[500]);
      case 'female':
        return Icon(FontAwesomeIcons.venus,
            size: iconSize, color: Colors.pink[500]);
      case 'hermaphrodite':
        return Icon(FontAwesomeIcons.transgender,
            size: iconSize, color: Colors.orangeAccent[400]);
      case 'n/a':
        return Icon(FontAwesomeIcons.genderless,
            size: iconSize, color: Colors.green[500]);
      default:
        return Icon(FontAwesomeIcons.genderless,
            size: iconSize, color: Colors.green[500]);
    }
  }
}
