import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/code/config.dart';

class Converters {
  toDouble(string, tipo) {
    //0 = kg; 1 = m;
    if (string != null) {
      if (string != 'unknown') {
        string = string.replaceAll(',', '');
        return '${double.parse(string) / (tipo == 1 ? 100 : 1)}${tipo == 1 ? 'm' : 'kg'}';
      } else {
        return 'unknown';
      }
    } else {
      return 'unknown';
    }
  }

  setGender(gender, iconSize) {
    switch (gender) {
      case 'male':
        return Tooltip(
          message: 'male',
          child: Icon(FontAwesomeIcons.mars,
              size: iconSize, color: Colors.blue[500]),
        );
      case 'female':
        return Tooltip(
          message: 'female',
          child: Icon(FontAwesomeIcons.venus,
              size: iconSize, color: Colors.pink[500]),
        );
      case 'hermaphrodite':
        return Tooltip(
          message: 'hermaphrodite',
          child: Icon(FontAwesomeIcons.transgender,
              size: iconSize, color: Colors.orangeAccent[400]),
        );
      case 'n/a':
        return Tooltip(
          message: 'n/a',
          child: Icon(FontAwesomeIcons.genderless,
              size: iconSize, color: Colors.green[500]),
        );
      default:
        return Tooltip(
          message: 'n/a',
          child: Icon(FontAwesomeIcons.genderless,
              size: iconSize, color: Colors.green[500]),
        );
    }
  }

  setSpecie(List<String>? url) {
    if (url!.isNotEmpty) {
      List<Specie> specie = Hive.box<Specie>(speciesBox)
          .values
          .toList()
          .where((specie) => specie.url == url.first)
          .toList();
      if (specie.isNotEmpty) {
        return specie.first.name;
      } else {
        return '';
      }
    } else {
      return 'Human';
    }
  }

  setRoman(int number) {
    switch (number) {
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      case 4:
        return 'IV';
      case 5:
        return 'V';
      case 6:
        return 'VI';
      case 7:
        return 'VII';
      case 8:
        return 'VII';
      case 9:
        return 'IX';
      default:
    }
  }
}
