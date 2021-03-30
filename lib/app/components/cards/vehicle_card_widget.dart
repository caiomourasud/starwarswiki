import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

class VehicleCardWidget extends StatelessWidget {
  final Vehicle vehicle;
  final Function onTap;

  const VehicleCardWidget({
    Key? key,
    required this.vehicle,
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
            Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  height: 110.0,
                  width: MediaQuery.of(context).size.width <= 420.0
                      ? MediaQuery.of(context).size.width * 0.30
                      : 130.0,
                  decoration: BoxDecoration(
                      color: CupertinoColors.darkBackgroundGray,
                      image: DecorationImage(
                          image: NetworkImage(ImageGenerator.generateImage(
                              id: vehicle.id, type: 'vehicles')),
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
                        child: Text(vehicle.name,
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
                          child: Text(vehicle.model,
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
