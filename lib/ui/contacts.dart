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
    storageId = "personal";
    _loadStorages();
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
                  storageId = "personal";
                  _changeList(storageId);
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
                  storageId = "team";
                  _changeList(storageId);
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

_changeList(String _id) async {
  var contactsInfo = await _apiContactsInfo.getContactsInfo(global.token, _id);
  List<String> uids = List();
  contactsInfo.result.info.forEach((i) => uids.add(i.uUID));
  var contactsInfoUids = await _apiContactsInfoUids.getContactsInfoUIDS(global.token, _id, uids);
  listContactsInfo = contactsInfoUids.result;
  subTitle = storages.result.firstWhere((f) => f.id == _id).name;
}

ApiContactStorages _apiContactStorages = ApiContactStorages();
ApiContactsInfo _apiContactsInfo = ApiContactsInfo();
ApiContactsInfoUids _apiContactsInfoUids = ApiContactsInfoUids();
var subTitle;
List<UserInfo> listContactsInfo = List();
Storages storages;
String storageId;
_loadStorages() async {
  storages = await _apiContactStorages.getContactStorages(global.token);
  storages.result.forEach((f) => (f.id == "team") ? global.tCTag = f.cTag : global.pCTag = f.cTag);
  print("Personal CTag -> ${global.pCTag}, Team CTag -> ${global.tCTag}");
  _changeList(storageId);
}

_loadSubTitle() async {
  storages = await _apiContactStorages.getContactStorages(global.token);
  subTitle = storages.result.firstWhere((f) => f.id == storageId).name;
}

Widget _futureListLoad(BuildContext context) {
  return FutureBuilder(
    future: _changeList(storageId),
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
