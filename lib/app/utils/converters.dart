import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';

final _speciesController = Modular.get<SpeciesController>();

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
    if (url != null) {
      if (url.length > 0) {
        List<Specie> specie = _speciesController.species
            .where((specie) => specie.url == url[0])
            .toList();
        return specie[0].name;
      } else {
        return 'Human';
      }
    } else {
      return 'Human';
    }
  }
}
