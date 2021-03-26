import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

class SpecieCardWidget extends StatelessWidget {
  final Specie specie;
  final Function onTap;

  const SpecieCardWidget({
    Key? key,
    required this.specie,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onTap(),
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  height: 80.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      color: CupertinoColors.darkBackgroundGray,
                      image: DecorationImage(
                        image: NetworkImage(ImageGenerator.generateImage(
                            id: specie.id, type: 'species')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.xor),
                      )),
                ),
                Center(
                  child: Text(specie.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .overline
                          ?.copyWith(color: Colors.white)),
                )
              ],
            )),
      ),
    );
  }
}
