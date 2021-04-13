import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/components/cached_image_widget.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/components/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        backButton: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints dimens) {
          return ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              Container(
                height: 72.0,
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                          height: 64.0,
                          width: 64.0,
                          child: CachedImageWidget(
                              url:
                                  'https://avatars.githubusercontent.com/u/45606785?s=400&u=89cb3fe93ca96002049f750183a8b3bed8dba1de&v=4')),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                'Caio Moura',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Opacity(
                              opacity: 0.6,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.location, size: 12),
                                  SizedBox(width: 2.0),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 1.0),
                                      child: Text(
                                        'Rio de Janeiro, RJ',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                            text: """I'm a""",
                          ),
                          TextSpan(
                              text: ' Flutter App Developer',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text:
                                """ and and I'm looking for new Flutter challenges to increase my portfolio.""",
                          )
                        ]),
                  )),
              SizedBox(height: 22.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(height: 1.0),
              ),
              SizedBox(height: 16.0),
              SocialMediaButtonWidget(
                  icon: FontAwesomeIcons.instagram,
                  text: '@caiomourasud',
                  onPressed: () =>
                      _launchURL('https://www.instagram.com/caiomourasud/')),
              SocialMediaButtonWidget(
                  icon: FontAwesomeIcons.linkedin,
                  text: 'linkedin.com/in/caiomourasud',
                  onPressed: () =>
                      _launchURL('https://www.linkedin.com/in/caiomourasud/')),
              SocialMediaButtonWidget(
                  icon: FontAwesomeIcons.github,
                  text: 'github.com/caiomourasud',
                  onPressed: () =>
                      _launchURL('https://github.com/caiomourasud')),
              SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }
}
