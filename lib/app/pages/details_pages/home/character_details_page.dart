import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/favorite_button_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/models/characteristics_list.dart';
import 'package:starwarswiki/app/models/database/people.dart';
import 'package:starwarswiki/app/pages/details_pages/home/planet_details_page.dart';
import 'package:starwarswiki/app/repositories/characters_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../../utils/capitalize.dart';

final _charactersController = Modular.get<CharactersController>();
final _charactersRepository = CharactersRepositiry();

class CharacterDetailsPage extends StatefulWidget {
  final People? character;
  final int backButton;

  const CharacterDetailsPage(
      {Key? key, this.character, required this.backButton})
      : super(key: key);
  @override
  _CharacterDetailsPageState createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    _charactersController.setList(widget);

    List<CharacteristicsList> info = [
      CharacteristicsList(
          title: 'Height',
          value: Converters().toDouble(widget.character!.height, 1),
          icon: CupertinoIcons.resize_v),
      CharacteristicsList(
          title: 'Mass',
          value: Converters().toDouble(widget.character!.mass, 0),
          icon: CupertinoIcons.timer),
      CharacteristicsList(
          title: 'Birth year',
          value: widget.character!.birthYear,
          icon: CupertinoIcons.gift),
      CharacteristicsList(
          title: 'Hair color',
          value: widget.character!.hairColor,
          icon: Icons.color_lens_rounded),
      CharacteristicsList(
          title: 'Eye color',
          value: widget.character!.eyeColor,
          icon: CupertinoIcons.eye),
      CharacteristicsList(
          title: 'Skin color',
          value: widget.character!.skinColor,
          icon: CupertinoIcons.hand_raised_fill)
    ];

    return Scaffold(
      appBar: CustomAppBar(
          title: widget.character!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          trailing: FavoriteButtonWidget(
            isFavorite: widget.character!.isFavorite,
            onPressed: () => setState(
              () => _charactersRepository.setFavorite(
                  context: context, id: widget.character!.id),
            ),
          )),
      body: LayoutBuilder(builder: (context, dimens) {
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: Scrollbar(
            child: ListView(
              padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
              children: [
                Container(
                  height: 140.0,
                  padding: EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          height: 136.0,
                          width: 130.0,
                          decoration: BoxDecoration(
                              color: CupertinoColors.darkBackgroundGray,
                              // ignore: unnecessary_null_comparison
                              image: DecorationImage(
                                  image: NetworkImage(
                                      ImageGenerator.generateImage(
                                          id: widget.character!.id,
                                          type: 'characters')),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.character!.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.0),
                              Row(
                                children: [
                                  Opacity(
                                    opacity: 0.8,
                                    child: Text(
                                      widget.character!.gender.capitalize(),
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                  SizedBox(width: 2.0),
                                  Converters()
                                      .setGender(widget.character!.gender, 12.0)
                                ],
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return PlanetDetailsPage(
                                        planet: _charactersController.planet,
                                        backButton: width > md ? 2 : 1);
                                  })),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.location_solid,
                                          size: 12,
                                          color: Theme.of(context).accentColor),
                                      SizedBox(width: 2.0),
                                      Text(
                                        _charactersController.planet!.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.0)
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(height: 0.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 12.0, right: 16.0, bottom: 0.0),
                  child:
                      Text('Characteristics', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 6.0),
                  child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: info.map((item) {
                        return Container(
                          height: 70.0,
                          width: width <= sm ? (width - 7.0) * 0.45 : 140.0,
                          decoration: new BoxDecoration(
                              color: Color(0x12cfcfcf),
                              border: Border.all(
                                  color: Theme.of(context).focusColor),
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(6.0),
                              )),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Opacity(
                                      opacity: 0.8,
                                      child: Text(
                                        item.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    Text(
                                      item.value.capitalize(),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(flex: 2, child: Container()),
                                    Opacity(
                                        opacity: 0.1, child: Icon(item.icon)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                ),
                SizedBox(height: 18.0),
                Observer(builder: (_) {
                  return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: CustomCardList()
                          .cardList(
                              context: context,
                              speciesTitle: 'Specie',
                              species: _charactersController.species.isNotEmpty
                                  ? _charactersController.species
                                  : null,
                              speciesBackButton: widget.backButton == 2 ? 1 : 2,
                              starships:
                                  _charactersController.starships.isNotEmpty
                                      ? _charactersController.starships
                                      : null,
                              starshipsBackButton:
                                  widget.backButton == 2 ? 1 : 2,
                              starshipsLines:
                                  _charactersController.starships.length > 4
                                      ? 2
                                      : 1,
                              vehicles:
                                  _charactersController.vehicles.isNotEmpty
                                      ? _charactersController.vehicles
                                      : null,
                              vehiclesBackButton:
                                  widget.backButton == 2 ? 1 : 2)
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
                              card: (index) =>
                                  item.card(context, dimens, index),
                              seeAll: false,
                              onTap: () => item.onSeeAllTap(context)))
                          .toList());
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
