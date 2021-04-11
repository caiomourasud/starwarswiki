import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_details.dart';
import 'package:starwarswiki/app/components/favorite_button_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/controllers/starships_controller.dart';
import 'package:starwarswiki/app/models/database/starship.dart';
import 'package:starwarswiki/app/repositories/starships_repository.dart';

final _starshipsController = Modular.get<StarshipsController>();
final _starshipsRepository = StarshipsRepositiry();

class StarshipDetailsPage extends StatefulWidget {
  final Starship? starship;
  final int backButton;

  const StarshipDetailsPage(
      {Key? key, required this.starship, required this.backButton})
      : super(key: key);
  @override
  _StarshipDetailsPageState createState() => _StarshipDetailsPageState();
}

class _StarshipDetailsPageState extends State<StarshipDetailsPage> {
  @override
  Widget build(BuildContext context) {
    _starshipsController.setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.starship!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          trailing: FavoriteButtonWidget(
            isFavorite: widget.starship!.isFavorite,
            onPressed: () => setState(
              () => _starshipsRepository.setFavorite(
                  context: context, id: widget.starship!.id),
            ),
          )),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              CustomDetails(
                id: widget.starship!.id,
                type: 'starships',
                name: widget.starship!.name,
                firstDetailText: 'Class',
                firstDetailValue: widget.starship!.starshipClass,
                secondDetailText: 'Model',
                secondDetailValue: widget.starship!.model,
              ),
              SizedBox(height: 24.0),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: CustomCardList()
                      .cardList(
                        context: context,
                        films: _starshipsController.films.isNotEmpty
                            ? _starshipsController.films
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
                      .toList()),
            ],
          ),
        );
      }),
    );
  }
}
