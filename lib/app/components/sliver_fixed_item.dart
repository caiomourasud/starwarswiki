import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverFixedItem extends SliverPersistentHeaderDelegate {
  final String texto;
  final Color fundo;
  final bool sombra;

  SliverFixedItem(this.texto, this.fundo, this.sombra);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
          decoration: new BoxDecoration(
            color: fundo,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0.0, 0.0),
                blurRadius: shrinkOffset > 0.0 && sombra ? 4.0 : 0.0,
                spreadRadius: -1.0,
                color: Colors.black54,
              ),
            ],
          ),
          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: 0.6,
            child: Text(texto, style: Theme.of(context).textTheme.bodyText2),
          ));

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
