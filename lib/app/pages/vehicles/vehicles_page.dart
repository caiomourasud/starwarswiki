import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'components/vehicle_listtile_widget.dart';
import 'vehicle_details/vehicle_details_page.dart';

final _vahiclesController = Modular.get<VehiclesController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Converters conversores = Converters();

bool selectable = false;

class VehiclesPage extends StatefulWidget {
  final int backButton;

  const VehiclesPage({Key? key, required this.backButton}) : super(key: key);
  @override
  _VehiclesPageState createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _vahiclesController.setSearchSize(78.0);
      } else {
        _vahiclesController.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    _vahiclesController.setSearchText('');
    _vahiclesController.setSearchSize(0.0);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints dimens) {
          return Row(
            children: [
              Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width > md
                    ? 380.0
                    : dimens.maxWidth,
                child: NestedScrollView(
                    controller: _vahiclesController.scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    body: Observer(builder: (_) {
                      return Scrollbar(
                        child: CustomScrollView(
                          slivers: [
                            CupertinoSliverRefreshControl(
                              refreshTriggerPullDistance: 100.0,
                              refreshIndicatorExtent: 60.0,
                              onRefresh: () async {
                                await Future<void>.delayed(
                                    const Duration(milliseconds: 1000));
                                if (_vahiclesController.vehicles.isEmpty) {
                                  _vahiclesController.getVehicles();
                                } else {
                                  _prefs
                                      .getString('next_vehicles')
                                      .then((data) {
                                    if (data != '') {
                                      _vahiclesController.getMoreVehicles(data);
                                    }
                                  });
                                }
                              },
                            ),
                            _sliverBody(
                                _vahiclesController.filterVehicles, dimens),
                          ],
                        ),
                      );
                    }),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        if (!_focus.hasFocus ||
                            MediaQuery.of(context).size.width > md)
                          _sliverAppBar(),
                        if (_focus.hasFocus &&
                            MediaQuery.of(context).size.width <= md)
                          _appBar(),
                        Observer(builder: (_) {
                          return SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: SearchBarWidget(
                                  size: _vahiclesController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  backButton: 2,
                                  onChange: (text) {
                                    _vahiclesController.setSearchText(text);
                                  },
                                  cancelar: _cancelar,
                                  texto: 'Search...',
                                  fullDimens: dimens));
                        }),
                      ];
                    }),
              ),
              if (MediaQuery.of(context).size.width > md)
                VerticalDivider(
                  width: 0.1,
                ),
              if (MediaQuery.of(context).size.width > md)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    height: double.infinity,
                    width: 0.08,
                    color: Colors.grey,
                  ),
                ),
              Observer(
                builder: (_) {
                  return _vahiclesController.vehicleSelected.id == 0
                      ? Expanded(
                          child: Scaffold(
                              body: Center(child: Text('No vehicle selected'))),
                        )
                      : Expanded(
                          child: ClipRect(
                            child: VehicleDetailsPage(
                                vehicle: _vahiclesController.vehicleSelected,
                                backButton: 0),
                          ),
                        );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  _sliverAppBar() {
    return CupertinoSliverAppBarWidget(
      context: context,
      title: 'Vehicles',
      backButton: 2,
      position: _vahiclesController.scrollPosition,
      titleActions: [],
      actions: [],
    );
  }

  _appBar() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: CupertinoAppBarWidget(
          context: context,
          title: 'Vehicles',
          backButton: 2,
          actions: [],
        ));
  }

  _sliverBody(List<Vehicle> vehicles, BoxConstraints dimens) {
    return _vahiclesController.res || _vahiclesController.vehicles.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return VehicleListTileWidget(
                  vehicle: _vahiclesController.filterVehicles[index],
                  onTap: (item) {
                    if (MediaQuery.of(context).size.width <= md) {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return VehicleDetailsPage(vehicle: item, backButton: 2);
                      }));
                    }
                    setState(() {
                      _vahiclesController.setVehicleSelected(
                          _vahiclesController.filterVehicles[index]);
                    });
                  },
                  vehicleSelected: _vahiclesController.vehicleSelected);
            }, childCount: _vahiclesController.filterVehicles.length),
          )
        : SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: dimens.maxHeight / 3),
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
  }
}
