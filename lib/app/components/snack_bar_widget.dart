import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  show(
      {required BuildContext context,
      required String mensagem,
      String? action,
      Function? onPressed}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(mensagem),
        action: action != null
            ? SnackBarAction(
                onPressed: () => onPressed!(),
                label: action,
              )
            : null,
      ),
    );
  }
}
