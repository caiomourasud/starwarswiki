import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'setting_details/setting_details_page.dart';
import 'settings_controller.dart';

final _settingsController = Modular.get<SettingsController>();

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    _settingsController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _settingsController.setScrollPosition(
        _settingsController.scrollController.position.pixels);
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
                      controller: _settingsController.scrollController,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      body: Scrollbar(
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Setting $index'),
                                  onTap: () {
                                    if (MediaQuery.of(context).size.width <=
                                        md) {
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return SettingDetailsPage();
                                      }));
                                    }
                                    setState(() {
                                      _settingsController
                                          .setSettingSelected(index);
                                    });
                                  },
                                );
                              },
                              childCount: 5,
                            ))
                          ],
                        ),
                      ),
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          _sliverAppBar(),
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
                    return _settingsController.settingSelected == 0
                        ? Expanded(
                            child: Scaffold(
                                body:
                                    Center(child: Text('No setting selected'))),
                          )
                        : Expanded(
                            child: ClipRect(
                              child: SettingDetailsPage(),
                            ),
                          );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _sliverAppBar() {
    return Observer(builder: (_) {
      return CupertinoSliverAppBarWidget(
        context: context,
        title: 'Settings',
        position: _settingsController.scrollPosition,
        titleActions: [
          // _listFavorites(
          //     paddingTop: 4.0,
          //     paddingRight: 16.0,
          //     disable: false,
          //     onTap: () => _planetsController.setShowFavorites(null))
        ],
        actions: [
          // _listFavorites(
          //     paddingTop: 4.0,
          //     paddingRight: 0.0,
          //     disable: _planetsController.scrollPosition <= 35.0,
          //     onTap: () => _planetsController.setShowFavorites(null))
        ],
      );
    });
  }
}
