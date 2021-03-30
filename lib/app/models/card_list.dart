import 'package:flutter/material.dart';

class CardList {
  final String title;
  final List list;
  final double height;
  final double width;
  final int rows;
  double viewportFraction;
  final bool hasDivider;
  final Function(BuildContext, BoxConstraints dimens, int) card;
  final Function(BuildContext) onSeeAllTap;

  CardList({
    required this.list,
    required this.title,
    required this.height,
    required this.width,
    required this.rows,
    required this.viewportFraction,
    this.hasDivider = true,
    required this.card,
    required this.onSeeAllTap,
  });
}
