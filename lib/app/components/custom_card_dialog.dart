import 'package:flutter/material.dart';
import 'package:starwarswiki/app/pages/main/default_view.dart';

class CustomCardDialog {
  open(
      {required BuildContext context,
      required BoxConstraints dimens,
      required Widget item}) {
    return showDialog(
      context: context,
      barrierColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black87
          : Colors.white10,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6.0)),
            backgroundColor: Theme.of(context).bottomAppBarColor,
            content: ConstrainedBox(
              constraints: BoxConstraints(minWidth: dimens.maxWidth / 1.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: DefaultView(
                  page: item,
                  actionList: [],
                ),
              ),
            ));
      },
    );
  }
}
