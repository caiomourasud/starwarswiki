import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';

final _appController = Modular.get<AppController>();

class AppearanceContent extends StatefulWidget {
  @override
  _AppearanceContentState createState() => _AppearanceContentState();
}

class _AppearanceContentState extends State<AppearanceContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Divider(height: 0.0),
          Opacity(
            opacity: !_appController.autoTheme ? 1.0 : 0.3,
            child: Container(
              color: Theme.of(context).cardColor,
              child: ListTile(
                title: Text('Dark side'),
                trailing: _appController.isDarkTheme
                    ? Icon(CupertinoIcons.checkmark_alt,
                        color: Theme.of(context).colorScheme.secondary)
                    : null,
                enabled: !_appController.autoTheme,
                onTap: () => setState(() => _appController.setDarkTheme(true)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Divider(height: 0.0)),
          Opacity(
            opacity: !_appController.autoTheme ? 1.0 : 0.3,
            child: Container(
              color: Theme.of(context).cardColor,
              child: ListTile(
                title: Text('Light side'),
                trailing: !_appController.isDarkTheme
                    ? Icon(CupertinoIcons.checkmark_alt,
                        color: Theme.of(context).colorScheme.secondary)
                    : null,
                enabled: !_appController.autoTheme,
                onTap: () => setState(() => _appController.setDarkTheme(false)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Divider(height: 0.0)),
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile.adaptive(
                title: Text('According to the soul'),
                value: _appController.autoTheme,
                onChanged: (value) => _appController.setAutoTheme(value)),
          ),
          Divider(height: 0.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Opacity(
              opacity: 0.6,
              child: Text(
                  """If According to the soul is selected, the App will automatically adjust its appearance based on your device's system settings."""),
            ),
          ),
          SizedBox(height: 32.0),
          Opacity(
            opacity: 0.6,
            child: Container(
              height: 352,
              child: Stack(
                children: <Widget>[
                  AnimatedOpacity(
                    opacity: Theme.of(context).brightness == Brightness.light
                        ? 1.0
                        : 0.0,
                    duration: Duration(milliseconds: 600),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RotatedBox(
                              quarterTurns: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('JEDI',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(color: Colors.blue[700])),
                                  SizedBox(width: 12.0),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(FontAwesomeIcons.oldRepublic,
                                        size: 50.0, color: Colors.blue[700]),
                                  )
                                ],
                              )),
                          SizedBox(width: 22.0),
                          Flexible(
                            child: Column(
                              children: [
                                Text('There is no emotion, there is',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('PEACE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('There is no ignorance, there is',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('KNOWLEDGE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('There is no passion, there is',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('SERENITY',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('There is no chaos, there is',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('HARMONY',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('There is no death, there is',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.blue[700])),
                                Text('THE FORCE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: Colors.blue[700]))
                              ],
                            ),
                          ),
                          SizedBox(width: 16.0),
                        ],
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: Theme.of(context).brightness == Brightness.dark
                        ? 1.0
                        : 0.0,
                    duration: Duration(milliseconds: 600),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RotatedBox(
                              quarterTurns: 3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('SITH',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(color: Colors.red[700])),
                                  SizedBox(width: 12.0),
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Icon(
                                        FontAwesomeIcons.galacticRepublic,
                                        size: 50.0,
                                        color: Colors.red[700]),
                                  )
                                ],
                              )),
                          SizedBox(width: 22.0),
                          Flexible(
                            child: Column(
                              children: [
                                Text('Peace is a lie. There is only',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700])),
                                Text('PASSION',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(color: Colors.red[700])),
                                Text('Through Passion I gain',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700])),
                                Text('STRENGTH',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: Colors.red[700])),
                                Text('Through Strength I gain',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700])),
                                Text('POWER',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(color: Colors.red[700])),
                                Text('Through Power I gain',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700])),
                                Text('VICTORY',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        ?.copyWith(color: Colors.red[700])),
                                Text('Through Victory ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700])),
                                Text('my chains are broken',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700])),
                                Text('THE FORCE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: Colors.red[700])),
                                Text('shall free me.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(color: Colors.red[700]))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 64.0),
        ],
      ),
    );
  }
}
