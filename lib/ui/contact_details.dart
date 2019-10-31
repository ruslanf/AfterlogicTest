import 'dart:io';

import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  final UserInfo userInfo;
  ContactDetails({Key key, @required this.userInfo}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Exit',
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
      body: Container(
        child: Wrap(
            alignment: WrapAlignment.start,
            children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                title: Text("Display name ${widget.userInfo.fullName}"),
              ),
              ListTile(
                title: Text("Email ${widget.userInfo.personalEmail}"),
              ),
              ListTile(
                title: Text("Address ${widget.userInfo.personalAddress}"),
              ),
              ListTile(
                title: Text("Skype ${widget.userInfo.skype}"),
              ),
              ListTile(
                title: Text("Facebook ${widget.userInfo.facebook}"),
              ),
            ]).toList()),
      ),
    );
  }
}
