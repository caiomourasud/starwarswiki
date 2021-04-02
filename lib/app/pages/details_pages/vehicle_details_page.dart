import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';

final _filmsController = Modular.get<FilmsController>();

List<Film> films = [];

class VehicleDetailsPage extends StatefulWidget {
  final Vehicle? vehicle;
  final int backButton;

  const VehicleDetailsPage(
      {Key? key, required this.vehicle, required this.backButton})
      : super(key: key);
  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

setList(widget) {
  films.clear();

  for (var vehicle in widget.vehicle.films) {
    films.addAll(_filmsController.films.where((ve) => vehicle == ve.url));
  }
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.vehicle!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              SizedBox(height: 24.0),
              if (films.isNotEmpty)
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CustomCardList()
                        .cardList(
                            context: context,
                            films: films.isNotEmpty ? films : null)
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
