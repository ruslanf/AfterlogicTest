import 'dart:io';

import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/http/api_contacts_info.dart';
import 'package:afterlogic_test/data/http/api_contacts_info_uids.dart';
import 'package:afterlogic_test/data/http/api_contact_storages.dart';
import 'package:afterlogic_test/data/models/contacts_info.dart';
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:afterlogic_test/ui/view/main_listview.dart';
import 'package:flutter/material.dart';
import 'package:afterlogic_test/common/globals.dart' as global;
import 'package:afterlogic_test/data/models/storages.dart';

class Contacts extends StatefulWidget {
  final String token;

  Contacts({Key key, @required this.token}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  Future<Storages> storages;
  Future<ContactsInfo> contactsInfo;
  String appBarTitle = TITLE_CONTACTS;
  String appBarSubTitle = "";

  @override
  void initState() {
    print("initState()...");
    global.token = widget.token;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _futureLoad(context),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh contacts',
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureListLoad(context);
              });
            },
          ),
          IconButton(
            tooltip: 'Exit',
            icon: Icon(Icons.exit_to_app),
            onPressed: () => exit(0),
          ),
        ],
      ),
      body: Center(
        child: _futureListLoad(context),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Contacts type"),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text("Personal"),
              onTap: () {
                setState(() {
                  Navigator.pop(context, true);
                  _changeList("personal");
                });
              }
            ),
            Divider(
              height: 2.0,
            ),
            ListTile(
              title: Text("Team"),
              onTap: () {
                setState(() {
                  Navigator.pop(context, true);
                  _changeList("team");
                });
              }
            ),
            Divider(
              height: 2.0,
            )
          ],
        ),
      ),
    );
  }
}

void _changeList(String _id) async {
  var contactsInfo = await getContactsInfo(global.token, _id);
  List<String> uids = List();
  contactsInfo.result.info.forEach((i) => uids.add(i.uUID));
  var contactsInfoUids = await getContactsInfoUIDS(global.token, _id, uids);
  listContactsInfo = contactsInfoUids.result;
}

var subTitle;
List<UserInfo> listContactsInfo = List();
_loadSubTitle() async {
  var _storages = await getContactStorages(global.token);
  subTitle = _storages.result.last.name;
}

_loadListContacts() async {
  var _storages = await getContactStorages(global.token);
  _changeList(_storages.result.last.id);
}

Widget _futureListLoad(BuildContext context) {
  return FutureBuilder(
    future: _loadListContacts(),
    builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);
      return (snapshot.connectionState == ConnectionState.done)
          ? MainListView(listContacts: listContactsInfo)
          : Center(
              child: CircularProgressIndicator(),
            );
    },
  );
}

Widget _futureLoad(BuildContext context) {
  return FutureBuilder(
    future: _loadSubTitle(),
    builder: (ctx, snapshot) {
      return (snapshot.connectionState == ConnectionState.done)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  TITLE_CONTACTS,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    },
  );
}
