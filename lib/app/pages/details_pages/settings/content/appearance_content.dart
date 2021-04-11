import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';

final _appController = Modular.get<AppController>();

class AppearanceContent extends StatefulWidget {
  @override
  _AppearanceContentState createState() => _AppearanceContentState();
}

class _AppearanceContentState extends State<AppearanceContent> {
  @override
  Widget build(BuildContext context) {
    Widget _genericText({required String text, Color? color, bool? isLarge}) =>
        Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.spectralSc(
                textStyle: isLarge ?? false
                    ? Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: color ?? Colors.blue[700])
                    : Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: color ?? Colors.blue[700], height: 0.8)));

    Widget _svgImage = SvgPicture.asset(
      'assets/icons/sith_empire.svg',
      height: 64.0,
      width: 64.0,
      fit: BoxFit.fitHeight,
      color: Colors.red[500],
      semanticsLabel: 'A red up arrow',
      placeholderBuilder: (BuildContext context) =>
          Container(child: const CircularProgressIndicator.adaptive()),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Divider(height: 0.0),
          Opacity(
            opacity: !_appController.autoTheme ? 1.0 : 0.3,
            child: Container(
              color: _appController.isDarkTheme
                  ? Theme.of(context).hoverColor
                  : Theme.of(context).cardColor,
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
              color: _appController.isDarkTheme
                  ? Theme.of(context).hoverColor
                  : Theme.of(context).cardColor,
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
            color: _appController.isDarkTheme
                ? Theme.of(context).hoverColor
                : Theme.of(context).cardColor,
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
          SizedBox(height: 52.0),
          Opacity(
            opacity: 0.7,
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
                                Text('Jedi',
                                    style: GoogleFonts.spectralSc(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                                color: Colors.blue[700]))),
                                SizedBox(width: 8.0),
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(FontAwesomeIcons.oldRepublic,
                                      size: 50.0, color: Colors.blue[700]),
                                )
                              ],
                            )),
                        SizedBox(width: 12.0),
                        Flexible(
                          child: Column(
                            children: [
                              _genericText(
                                  text: 'There is no emotion, there is'),
                              _genericText(text: 'PEACE', isLarge: true),
                              _genericText(
                                  text: 'There is no ignorance, there is'),
                              _genericText(text: 'KNOWLEDGE', isLarge: true),
                              _genericText(
                                  text: 'There is no passion, there is'),
                              _genericText(text: 'SERENITY', isLarge: true),
                              _genericText(text: 'There is no chaos, there is'),
                              _genericText(text: 'HARMONY', isLarge: true),
                              _genericText(text: 'There is no death, there is'),
                              _genericText(text: 'THE FORCE', isLarge: true),
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
                                Text('Sith',
                                    style: GoogleFonts.spectralSc(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(
                                                color: Colors.red[500]))),
                                SizedBox(width: 8.0),
                                RotatedBox(quarterTurns: 1, child: _svgImage)
                              ],
                            )),
                        SizedBox(width: 12.0),
                        Flexible(
                          child: Column(
                            children: [
                              _genericText(
                                  text: 'Peace is a lie. There is only',
                                  color: Colors.red[500]),
                              _genericText(
                                  text: 'PASSION',
                                  color: Colors.red[500],
                                  isLarge: true),
                              _genericText(
                                  text: 'Through Passion I gain',
                                  color: Colors.red[500]),
                              _genericText(
                                  text: 'STRENGTH',
                                  color: Colors.red[500],
                                  isLarge: true),
                              _genericText(
                                  text: 'Through Strength I gain',
                                  color: Colors.red[500]),
                              _genericText(
                                  text: 'POWER',
                                  color: Colors.red[500],
                                  isLarge: true),
                              _genericText(
                                  text: 'Through Power I gain',
                                  color: Colors.red[500]),
                              _genericText(
                                  text: 'VICTORY',
                                  color: Colors.red[500],
                                  isLarge: true),
                              _genericText(
                                  text: 'Through Victory',
                                  color: Colors.red[500]),
                              _genericText(
                                  text: 'my chains are broken',
                                  color: Colors.red[500]),
                              _genericText(
                                  text: 'THE FORCE',
                                  color: Colors.red[500],
                                  isLarge: true),
                              _genericText(
                                  text: 'shall free me.',
                                  color: Colors.red[500])
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
          SizedBox(height: 42.0),
        ],
      ),
    );
  }
}
