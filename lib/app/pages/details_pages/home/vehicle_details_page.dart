import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_details.dart';
import 'package:starwarswiki/app/components/favorite_button_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/repositories/vehicles_repository.dart';

final _vehiclesController = Modular.get<VehiclesController>();
final _vehiclesRepository = VehiclesRepositiry();

class VehicleDetailsPage extends StatefulWidget {
  final Vehicle? vehicle;
  final int backButton;

  const VehicleDetailsPage(
      {Key? key, required this.vehicle, required this.backButton})
      : super(key: key);
  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    _vehiclesController.setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.vehicle!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          trailing: FavoriteButtonWidget(
            isFavorite: widget.vehicle!.isFavorite,
            onPressed: () => setState(
              () => _vehiclesRepository.setFavorite(
                  context: context, id: widget.vehicle!.id),
            ),
          )),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              CustomDetails(
                id: widget.vehicle!.id,
                type: 'vehicles',
                name: widget.vehicle!.name,
                firstDetailText: 'Class',
                firstDetailValue: widget.vehicle!.vehicleClass,
                secondDetailText: 'Model',
                secondDetailValue: widget.vehicle!.model,
              ),
              SizedBox(height: 24.0),
              if (_vehiclesController.films.isNotEmpty)
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CustomCardList()
                        .cardList(
                            context: context,
                            films: _vehiclesController.films.isNotEmpty
                                ? _vehiclesController.films
                                : null)
                        .map((item) => CustomHorizontalList().list(
                            context: context,
                            title: item.title,
                            height: item.height *
                                (item.list.length > 3 ? item.rows : 1),
                            width: item.width *
                                (item.list.length > 3 ? item.rows : 1),
                            rows: item.list.length > 3 ? item.rows : 1,
                            viewportFraction: item.viewportFraction,
                            cards: item.list,
                            card: (index) => item.card(context, dimens, index),
                            seeAll: false,
                            onTap: () => item.onSeeAllTap(context)))
                        .toList()),
            ],
          ),
        );
      }),
    );
  }
}
