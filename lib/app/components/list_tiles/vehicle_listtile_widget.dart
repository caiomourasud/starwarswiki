import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../utils/capitalize.dart';

Converters conversores = Converters();

class VehicleListTileWidget extends StatelessWidget {
  final int vehicleSelected;
  final Vehicle vehicle;
  final Function(Vehicle) onTap;

  const VehicleListTileWidget(
      {Key? key,
      required this.vehicleSelected,
      required this.vehicle,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: vehicleSelected == vehicle.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          onTap(vehicle);
        },
        subtitle: Container(
            height: 70.0,
            child: LineContent(
                id: vehicle.id,
                type: 'vehicles',
                topText: Opacity(
                  opacity: 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(vehicle.model.capitalize(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.overline),
                      ),
                    ],
                  ),
                ),
                title: vehicle.name,
                subtitle: Opacity(
                  opacity: 0.6,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(vehicle.manufacturer,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }
}
