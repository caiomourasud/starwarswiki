import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  show(BuildContext context, String mensagem) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(mensagem),
      ),
    );
  }
}
