import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

import '../utils/capitalize.dart';

class CustomDetails extends StatelessWidget {
  final int id;
  final String type;
  final String name;
  final String firstDetailText;
  final String firstDetailValue;
  final String secondDetailText;
  final String secondDetailValue;

  const CustomDetails(
      {Key? key,
      required this.id,
      required this.type,
      required this.name,
      required this.firstDetailText,
      required this.firstDetailValue,
      required this.secondDetailText,
      required this.secondDetailValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              height: 144.0,
              width: 138.0,
              decoration: BoxDecoration(
                  color: CupertinoColors.darkBackgroundGray,
                  image: DecorationImage(
                      image: NetworkImage(
                          ImageGenerator.generateImage(id: id, type: type)),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 4.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          height: 1.0,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SizedBox(height: 2.0),
              Opacity(
                opacity: 0.8,
                child: Text(
                  firstDetailText,
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      firstDetailValue.capitalize(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  SizedBox(width: 2.0),
                ],
              ),
              SizedBox(height: 4.0),
              Opacity(
                opacity: 0.8,
                child: Text(
                  secondDetailText,
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      secondDetailValue.capitalize(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  SizedBox(width: 2.0),
                ],
              ),
              SizedBox(height: 4.0)
            ]),
          ),
        ],
      ),
    );
  }
}
