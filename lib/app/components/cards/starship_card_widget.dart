import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

class StarshipCardWidget extends StatelessWidget {
  final Starship starship;
  final Function onTap;

  const StarshipCardWidget({
    Key? key,
    required this.starship,
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
                            id: starship.id, type: 'starships')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.xor),
                      )),
                ),
                Center(
                  child: Text(starship.name,
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
