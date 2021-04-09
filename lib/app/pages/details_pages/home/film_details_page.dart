import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';
import 'package:starwarswiki/app/models/database/film.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/repositories/films_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

final _filmsController = Modular.get<FilmsController>();
final _charactersController = Modular.get<CharactersController>();
final _filmsRepository = FilmsRepositiry();

class FilmDetailsPage extends StatefulWidget {
  final Film? film;
  final int backButton;

  const FilmDetailsPage({Key? key, this.film, required this.backButton})
      : super(key: key);
  @override
  _FilmDetailsPageState createState() => _FilmDetailsPageState();
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  @override
  Widget build(BuildContext context) {
    _filmsController.setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.film!.title,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          trailing: Tooltip(
              message: widget.film!.isFavorite ? 'Remover' : 'Favoritar',
              child: CupertinoButton(
                  minSize: 30,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                      widget.film!.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      size: 28),
                  onPressed: () => setState(
                        () => _filmsRepository.setFavorite(
                            context: context, id: widget.film!.id),
                      )))),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: 280.0,
                        width: 170.0,
                        decoration: BoxDecoration(
                            color: CupertinoColors.darkBackgroundGray,
                            image: DecorationImage(
                              image: NetworkImage(ImageGenerator.generateImage(
                                  id: widget.film!.id, type: 'films')),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.1), BlendMode.xor),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Container(
                        height: 280.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.film!.title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 4.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Episode ${Converters().setRoman(widget.film!.episodeId)}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Director',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Text(
                              widget.film!.director,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(height: 12.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Producer',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Text(
                              widget.film!.producer,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(height: 12.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Release year',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy').format(
                                  DateTime.parse(widget.film!.releaseDate)),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Observer(builder: (_) {
                _charactersController.people.where(
                    (character) => widget.film!.characters[0] == character.url);
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CustomCardList()
                        .cardList(
                            context: context,
                            characters: _filmsController.characters,
                            charactersBackButton:
                                widget.backButton == 2 ? 1 : 2,
                            charactersLines:
                                _filmsController.characters.length > 6 ? 3 : 2,
                            planets: _filmsController.planets,
                            planetsBackButton: widget.backButton == 2 ? 1 : 2,
                            species: _filmsController.species,
                            speciesBackButton: widget.backButton == 2 ? 1 : 2,
                            speciesLines: 2,
                            starships: _filmsController.starships,
                            starshipsBackButton: widget.backButton == 2 ? 1 : 2,
                            starshipsLines:
                                _filmsController.starships.length > 4 ? 2 : 1,
                            vehicles: _filmsController.vehicles,
                            vehiclesBackButton: widget.backButton == 2 ? 1 : 2)
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
                            hasDivider: item.hasDivider,
                            seeAll: false,
                            onTap: () => item.onSeeAllTap(context)))
                        .toList());
              }),
              SizedBox(height: 48.0),
            ],
          ),
        );
      }),
    );
  }
}
