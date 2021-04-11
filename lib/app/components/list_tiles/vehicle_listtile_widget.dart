import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../utils/capitalize.dart';
import '../favorite_button_widget.dart';

Converters conversores = Converters();

class VehicleListTileWidget extends StatefulWidget {
  final int vehicleSelected;
  final Vehicle vehicle;
  final Function(Vehicle) onTap;
  final Function(int) onFavoriteTap;

  const VehicleListTileWidget(
      {Key? key,
      required this.vehicleSelected,
      required this.vehicle,
      required this.onTap,
      required this.onFavoriteTap})
      : super(key: key);

  @override
  _VehicleListTileWidgetState createState() => _VehicleListTileWidgetState();
}

class _VehicleListTileWidgetState extends State<VehicleListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: widget.vehicleSelected == widget.vehicle.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          widget.onTap(widget.vehicle);
        },
        subtitle: Container(
            height: 70.0,
            child: LineContent(
                id: widget.vehicle.id,
                type: 'vehicles',
                topText: Opacity(
                  opacity: 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.vehicle.model.capitalize(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.overline),
                      ),
                    ],
                  ),
                ),
                title: widget.vehicle.name,
                subtitle: Opacity(
                  opacity: 0.6,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.vehicle.manufacturer,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  ),
                ),
                button: FavoriteButtonWidget(
                    isFavorite: widget.vehicle.isFavorite,
                    onPressed: () => setState(
                        () => widget.onFavoriteTap(widget.vehicle.id))))),
      ),
    );
  }
}
