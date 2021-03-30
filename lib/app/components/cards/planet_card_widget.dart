import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      height: 110.0,
                      width: MediaQuery.of(context).size.width <= sm
                          ? MediaQuery.of(context).size.width * 0.30
                          : 130.0,
                      decoration: BoxDecoration(
                          color: CupertinoColors.darkBackgroundGray,
                          image: planet.id != 28 && planet.id != 46
                              ? DecorationImage(
                                  image: NetworkImage(
                                      ImageGenerator.generateImage(
                                          id: planet.id, type: 'planets')),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover)
                              : null),
                    )),
                if (planet.id == 28 || planet.id == 46)
                  Container(
                    height: MediaQuery.of(context).size.width <= sm
                        ? MediaQuery.of(context).size.width * 0.27
                        : 110.0,
                    width: MediaQuery.of(context).size.width <= sm
                        ? MediaQuery.of(context).size.width * 0.30
                        : 110.0,
                    child: Center(
                      child: Text('no image',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: Colors.white)),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(planet.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(planet.terrain,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.overline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
