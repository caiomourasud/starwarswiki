import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

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
    double width = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onTap(),
        child: Column(
          children: [
            Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  height: 80.0,
                  width: width <= sm ? width * 0.45 : 150.0,
                  decoration: BoxDecoration(
                      color: CupertinoColors.darkBackgroundGray,
                      image: DecorationImage(
                          image: NetworkImage(ImageGenerator.generateImage(
                              id: specie.id, type: 'species')),
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover)),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(specie.name,
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
                          child: Text(specie.classification,
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
