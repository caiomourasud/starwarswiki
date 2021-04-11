import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_details.dart';
import 'package:starwarswiki/app/components/favorite_button_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/controllers/planets_controller.dart';
import 'package:starwarswiki/app/models/database/planet.dart';
import 'package:starwarswiki/app/repositories/planets_repository.dart';

final _planetsController = Modular.get<PlanetsController>();
final _charactersController = Modular.get<CharactersController>();
final _planetsRepository = PlanetsRepositiry();

class PlanetDetailsPage extends StatefulWidget {
  final Planet? planet;
  final int backButton;

  const PlanetDetailsPage(
      {Key? key, required this.planet, required this.backButton})
      : super(key: key);
  @override
  _PlanetDetailsPageState createState() => _PlanetDetailsPageState();
}

class _PlanetDetailsPageState extends State<PlanetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    _planetsController.setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.planet!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          trailing: FavoriteButtonWidget(
            isFavorite: widget.planet!.isFavorite,
            onPressed: () => setState(
              () => _planetsRepository.setFavorite(
                  context: context, id: widget.planet!.id),
            ),
          )),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              CustomDetails(
                id: widget.planet!.id,
                type: 'planets',
                name: widget.planet!.name,
                firstDetailText: 'Climate',
                firstDetailValue: widget.planet!.climate,
                secondDetailText: 'Terrain',
                secondDetailValue: widget.planet!.terrain,
              ),
              SizedBox(height: 24.0),
              Observer(builder: (_) {
                _charactersController.people.where((character) =>
                    widget.planet!.residents[0] == character.url);
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CustomCardList()
                        .cardList(
                          context: context,
                          characters: _planetsController.characters.isNotEmpty
                              ? _planetsController.characters
                              : null,
                          charactersTitle: 'Residents',
                          charactersLines:
                              _planetsController.characters.length > 6 ? 2 : 1,
                          films: _planetsController.films.isNotEmpty
                              ? _planetsController.films
                              : null,
                        )
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
                        .toList());
              }),
            ],
          ),
        );
      }),
    );
  }
}
