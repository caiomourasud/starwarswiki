import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CupertinoSliverAppBarWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<Widget> titleActions;
  final List<Widget> actions;
  final double position;

  const CupertinoSliverAppBarWidget({
    Key? key,
    required this.context,
    required this.title,
    required this.titleActions,
    required this.actions,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(context) {
    return CupertinoSliverNavigationBar(
      stretch: true,
      brightness: Theme.of(context).brightness,
      middle: AnimatedOpacity(
        opacity: position > 35.0 ? 1.0 : 0.0,
        duration: Duration(milliseconds: 100),
        child: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      previousPageTitle: '',
      automaticallyImplyTitle: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      largeTitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (position <= 35.0)
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black87
                        : Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          if (position <= 35.0)
            Row(
              children: titleActions,
            )
        ],
      ),
      trailing: AnimatedOpacity(
          opacity: position > 35.0 ? 1.0 : 0.0,
          duration: Duration(milliseconds: 100),
          child: Row(mainAxisSize: MainAxisSize.min, children: actions)),
      border: position > 142.0 + MediaQuery.of(context).viewPadding.top
          ? Border(bottom: BorderSide(width: 0, color: Colors.black26))
          : Border.all(color: Colors.transparent),
    );
  }
}

class CupertinoAppBarWidget extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final String title;
  final List<Widget> actions;

  const CupertinoAppBarWidget(
      {required this.context, required this.title, required this.actions});

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return CupertinoNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Colors.transparent),
        middle: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary),
        ),
        trailing: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            )));
  }

  @override
  double get maxExtent => (44.0 + MediaQuery.of(context).viewPadding.top);

  @override
  double get minExtent => (44.0 + MediaQuery.of(context).viewPadding.top);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
