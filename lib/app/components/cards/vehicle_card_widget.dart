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
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                      color: CupertinoColors.darkBackgroundGray,
                      image: DecorationImage(
                        image: NetworkImage(ImageGenerator.generateImage(
                            id: vehicle.id, type: 'vehicles')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.xor),
                      )),
                ),
                Center(
                  child: Text(vehicle.name,
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
