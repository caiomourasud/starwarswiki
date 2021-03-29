import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

class PlanetCardWidget extends StatelessWidget {
  final Planet planet;
  final Function onTap;

  const PlanetCardWidget({
    Key? key,
    required this.planet,
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
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(50.0)),
            child: Stack(
              children: [
                if (planet.id != 28 && planet.id != 46)
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        color: CupertinoColors.darkBackgroundGray,
                        image: DecorationImage(
                          image: NetworkImage(ImageGenerator.generateImage(
                              id: planet.id, type: 'planets')),
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.4), BlendMode.xor),
                        )),
                  ),
                Center(
                  child: Text(planet.name,
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
