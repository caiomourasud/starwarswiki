import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/navigation/custom_blur_appbar.dart';
import 'package:starwarswiki/app/models/setting_list.dart';
import 'package:starwarswiki/app/pages/details_pages/settings/github_page.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'details_pages/settings/appearance_page.dart';
import '../controllers/settings_controller.dart';
import 'details_pages/settings/feedback_page.dart';
import 'details_pages/settings/profile_page.dart';

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
    double width = MediaQuery.of(context).size.width;
    List<SettingList> settings = [
      SettingList(
          id: 1,
          title: 'Caio Moura',
          subtitle: 'Flutter App Developer',
          trailing: Icon(CupertinoIcons.chevron_forward,
              size: 18,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100)),
          page: ProfilePage()),
      SettingList(
          id: 2,
          title: 'Appearance',
          subtitle: 'Select the theme to be used',
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                      Theme.of(context).brightness == Brightness.light
                          ? 'Light side'
                          : 'Dark side',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
              ),
              Icon(CupertinoIcons.chevron_forward,
                  size: 18,
                  color:
                      Theme.of(context).colorScheme.onSurface.withAlpha(100)),
            ],
          ),
          page: AppearancePage()),
      SettingList(
          id: 3,
          title: 'Repository',
          subtitle: 'caiomourasud/starwarswiki',
          trailing: Icon(CupertinoIcons.chevron_forward,
              size: 18,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100)),
          page: GithubPage()),
      SettingList(id: 99, title: '', page: Container(), trailing: SizedBox()),
      SettingList(
          id: 4,
          title: 'Feedback',
          trailing: Icon(CupertinoIcons.chevron_forward,
              size: 18,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100)),
          page: FeedbackPage()),
      SettingList(
          id: 98,
          title: 'Version 1.0.0',
          trailing: SizedBox(),
          page: Scaffold()),
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
                    width: width > md ? 380.0 : dimens.maxWidth,
                    child: CustomScrollView(
                      controller: _settingsController.scrollController,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: <Widget>[
                        Observer(builder: (_) {
                          return CustomBlurAppBar(
                              title: 'Settings',
                              position: _settingsController.scrollPosition);
                        }),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return settings[index].id == 99
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(height: 1.0),
                                  )
                                : settings[index].id == 98
                                    ? ListTile(
                                        title: Row(
                                        children: [
                                          Flexible(
                                            child: Opacity(
                                              opacity: 0.6,
                                              child: Text('Version 1.0.0',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface)),
                                            ),
                                          ),
                                        ],
                                      ))
                                    : Observer(builder: (_) {
                                        return ListTile(
                                          selected: settings[index].id ==
                                                  _settingsController
                                                      .settingSelected &&
                                              width > md,
                                          selectedTileColor:
                                              Theme.of(context).focusColor,
                                          title: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                    settings[index].title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface)),
                                              ),
                                            ],
                                          ),
                                          subtitle: settings[index].subtitle ==
                                                  null
                                              ? null
                                              : Opacity(
                                                  opacity: 0.6,
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 1.0),
                                                          child: Text(
                                                              settings[index]
                                                                  .subtitle!,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onSurface)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          dense: true,
                                          trailing: settings[index].trailing,
                                          onTap: () {
                                            if (width <= md) {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      title:
                                                          settings[index].title,
                                                      builder: (context) {
                                                        return settings[index]
                                                            .page;
                                                      }));
                                            }
                                            setState(() {
                                              _settingsController
                                                  .setSettingSelected(
                                                      settings[index].id);
                                            });
                                          },
                                        );
                                      });
                          },
                          childCount: settings.length,
                        ))
                      ],
                    )),
                if (width > md)
                  VerticalDivider(
                    width: 0.1,
                  ),
                if (width > md)
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
                    return _settingsController.settingSelected > 0 && width > md
                        ? Expanded(
                            child: ClipRect(
                              child: settings[
                                      _settingsController.settingSelected - 1]
                                  .page,
                            ),
                          )
                        : Expanded(
                            child: Center(child: Text('No setting selected')));
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
