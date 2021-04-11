import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_details.dart';
import 'package:starwarswiki/app/components/favorite_button_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/models/database/specie.dart';
import 'package:starwarswiki/app/repositories/species_repository.dart';

final _speciesController = Modular.get<SpeciesController>();
final _charactersController = Modular.get<CharactersController>();
final _speciesRepository = SpeciesRepositiry();

class SpecieDetailsPage extends StatefulWidget {
  final Specie? specie;
  final int backButton;

  const SpecieDetailsPage(
      {Key? key, required this.specie, required this.backButton})
      : super(key: key);
  @override
  _SpecieDetailsPageState createState() => _SpecieDetailsPageState();
}

class _SpecieDetailsPageState extends State<SpecieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    _speciesController.setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.specie!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          trailing: FavoriteButtonWidget(
            isFavorite: widget.specie!.isFavorite,
            onPressed: () => setState(
              () => _speciesRepository.setFavorite(
                  context: context, id: widget.specie!.id),
            ),
          )),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              CustomDetails(
                id: widget.specie!.id,
                type: 'species',
                name: widget.specie!.name,
                firstDetailText: 'Classification',
                firstDetailValue: widget.specie!.classification,
                secondDetailText: 'Language',
                secondDetailValue: widget.specie!.language,
              ),
              SizedBox(height: 24.0),
              Observer(builder: (_) {
                _charactersController.people.where(
                    (character) => widget.specie!.people[0] == character.url);
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CustomCardList()
                        .cardList(
                            context: context,
                            characters: _speciesController.characters.isNotEmpty
                                ? _speciesController.characters
                                : null,
                            films: _speciesController.films.isNotEmpty
                                ? _speciesController.films
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
                        .toList());
              }),
            ],
          ),
        );
      }),
    );
  }
}
