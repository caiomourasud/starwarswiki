import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class VehicleDetailsPage extends StatefulWidget {
  final Vehicle vehicle;
  final int backButton;

  const VehicleDetailsPage(
      {Key? key, required this.vehicle, required this.backButton})
      : super(key: key);
  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backButton == 2 ? Colors.transparent : null,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md ||
            widget.backButton == 1 ||
            widget.backButton == 2,
        brightness: Theme.of(context).brightness,
        backgroundColor: widget.backButton == 2
            ? Theme.of(context).bottomAppBarColor
            : Theme.of(context).scaffoldBackgroundColor,
        leading: widget.backButton == 2
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.maybePop(context),
                child: Icon(CupertinoIcons.clear),
              )
            : null,
        middle: Text(
          widget.vehicle.name,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Container(),
    );
  }
}
