import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/models/setting_list.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'details_pages/setting_details_page.dart';
import '../controllers/settings_controller.dart';

final _settingsController = Modular.get<SettingsController>();

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<SettingList> settings = [
      SettingList(
          id: 1,
          title: 'Caio Moura',
          subtitle: 'Flutter Developer',
          trailing: SizedBox()),
      SettingList(
          id: 2,
          title: 'Appearance',
          subtitle: 'Select the theme to be used',
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Text('Dark Side', style: Theme.of(context).textTheme.caption),
            Icon(
              CupertinoIcons.forward,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary,
            )
          ])),
      // SettingList(id: 3, title: '', subtitle: '', trailing: SizedBox()),
    ];

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
                                  selected: settings[index].id ==
                                          _settingsController.settingSelected &&
                                      MediaQuery.of(context).size.width > md,
                                  selectedTileColor:
                                      Theme.of(context).focusColor,
                                  title: Text(settings[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  subtitle: Text(settings[index].subtitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                  trailing: settings[index].trailing,
                                  onTap: () {
                                    if (MediaQuery.of(context).size.width <=
                                        md) {
                                      Navigator.push(context,
                                          CupertinoPageRoute(
                                              builder: (context) {
                                        return SettingDetailsPage(
                                          title: settings[index].title,
                                        );
                                      }));
                                    }
                                    setState(() {
                                      _settingsController.setSettingSelected(
                                          settings[index].id);
                                    });
                                  },
                                );
                              },
                              childCount: settings.length,
                            ))
                          ],
                        ),
                      ),
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          CupertinoSliverNavigationBar(
                            automaticallyImplyLeading: false,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            largeTitle: Text('Settings',
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black87
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimary)),
                            // leading: CupertinoButton(
                            //   minSize: 34,
                            //   padding: EdgeInsets.zero,
                            //   borderRadius: BorderRadius.circular(50.0),
                            //   child: Icon(Theme.of(context).brightness ==
                            //           Brightness.light
                            //       ? FontAwesomeIcons.jediOrder
                            //       : FontAwesomeIcons.galacticRepublic),
                            //   onPressed: () {},
                            // ),
                            border: Border.all(color: Colors.transparent),
                          )
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
                              child: SettingDetailsPage(
                                title: settings[
                                        _settingsController.settingSelected - 1]
                                    .title,
                              ),
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
}
