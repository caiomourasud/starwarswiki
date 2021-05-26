import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/components/cached_image_widget.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/components/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

class GithubPage extends StatefulWidget {
  @override
  _GithubPageState createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'GitHub',
        backButton: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints dimens) {
          return ListView(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 22.0),
            children: [
              Container(
                height: 236.0,
                child: CachedImageWidget(
                    url:
                        'https://media-exp1.licdn.com/dms/image/sync/C4E27AQGchIg04EAD_Q/articleshare-shrink_800/0/1617826231479?e=1618416000&v=beta&t=vDq7ZITKrkXV4mOaShMczcKc_AnyOHtpro8IN2St13w'),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'About',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'This application is being created for me redeem myself from a Flutter challenge that I did recently and did not do very well.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 17),
                ),
              ),
              SizedBox(height: 22.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(height: 1.0),
              ),
              SizedBox(height: 16.0),
              SocialMediaButtonWidget(
                  icon: FontAwesomeIcons.github,
                  text: 'github.com/caiomourasud/starwarswiki',
                  onPressed: () => _launchURL(
                      'https://github.com/caiomourasud/starwarswiki')),
              SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }
}
