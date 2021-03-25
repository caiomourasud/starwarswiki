import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class VehicleDetailsPage extends StatefulWidget {
  final Vehicle vehicle;

  const VehicleDetailsPage({Key? key, required this.vehicle}) : super(key: key);
  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md,
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
