import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

Converters conversores = Converters();

class SpecieListTileWidget extends StatelessWidget {
  final int specieSelected;
  final Specie specie;
  final Function(Specie) onTap;

  const SpecieListTileWidget(
      {Key? key,
      required this.specieSelected,
      required this.specie,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: specieSelected == specie.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          onTap(specie);
        },
        subtitle: Container(
            height: 50.0,
            child: LineContent(
                id: specie.id,
                type: 'species',
                title: specie.name,
                subtitle: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(specie.classification,
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ))),
      ),
    );
  }
}
