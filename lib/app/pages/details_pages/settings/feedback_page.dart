import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/utils/email_validation.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Feedback',
        backButton: 2,
        trailing: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text('Send',
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Theme.of(context).accentColor)),
            onPressed: () {
              FocusScope.of(context).unfocus();
              // onTap();
            },
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints dimens) {
          return ListView(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 22.0),
            children: [
              Divider(height: 1.0),
              ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('From:'),
                    ],
                  ),
                  title: CupertinoTextFormFieldRow(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      minLines: 1,
                      maxLines: 2,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      placeholder: 'Your email goes here',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      decoration: BoxDecoration(color: Colors.transparent),
                      validator: (value) =>
                          EmailValidation().validate(value!))),
              Divider(height: 1.0),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CupertinoTextField(
                  minLines: 6,
                  maxLines: 12,
                  placeholder:
                      'Do you want to send feedback? I want to hear your opinion.',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(height: 22.0)
            ],
          );
        },
      ),
    );
  }
}
