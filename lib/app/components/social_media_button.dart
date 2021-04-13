import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SocialMediaButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;

  const SocialMediaButtonWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(opacity: 0.6, child: Icon(icon, size: 18)),
          SizedBox(width: 8.0),
          Flexible(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 26.0,
                child: Text(text, style: Theme.of(context).textTheme.subtitle1),
                onPressed: () => onPressed(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
