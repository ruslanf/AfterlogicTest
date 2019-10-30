import 'dart:io';

import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/http/api.dart';
import 'package:afterlogic_test/data/http/api_contacts_info.dart';
import 'package:afterlogic_test/data/http/api_contacts_info_uids.dart';
import 'package:afterlogic_test/data/http/api_contact_storages.dart';
import 'package:afterlogic_test/data/models/contacts_info.dart';
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:flutter/material.dart';
import 'package:afterlogic_test/common/globals.dart' as global;
import 'package:afterlogic_test/data/models/storages.dart';

import 'contact_details.dart';

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
              // _futureListLoad(context);
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
              onTap: () => _changeList("personal"),
            ),
            ListTile(
              title: Text("Team"),
              onTap: () => _changeList("team"),
            )
          ],
        ),
      ),
    );
  }
}

_changeList(String _id) async {
  var contactsInfo = await getContactsInfo(global.token, _id);
  List<String> uids = List();
  contactsInfo.result.info.forEach((i) => uids.add(i.uUID));
  print("List uids -> $uids");
  var contactsInfoUids = await getContactsInfoUIDS(global.token, id, uids);
  print("List contacts -> $listContactsInfo");
  listContactsInfo = contactsInfoUids.result;
}

_openContactDetails(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetails()));
}

var subTitle;
var id;
List<UserInfo> listContactsInfo = List();
_loadSubTitle() async {
  var _storages = await getContactStorages(global.token);
  subTitle = _storages.result.last.name;
}

_loadListContacts() async {
  var _storages = await getContactStorages(global.token);
  id = _storages.result.first.id;
  var contactsInfo = await getContactsInfo(global.token, id);
  List<String> uids = List();
  contactsInfo.result.info.forEach((i) => uids.add(i.uUID));
  print("List uids -> $uids");
  var contactsInfoUids = await getContactsInfoUIDS(global.token, id, uids);
  print("List contacts -> $listContactsInfo");
  listContactsInfo = contactsInfoUids.result;
  print("listContactsInfo length -> ${listContactsInfo.length}");
}

Widget _futureListLoad(BuildContext context) {
  return FutureBuilder(
    future: _loadListContacts(),
    builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return ListView.builder(
          itemCount: listContactsInfo.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listContactsInfo[index].fullName),
              subtitle: Text(listContactsInfo[index].personalEmail),
              onTap: () {},
            );
          },
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

Widget _futureLoad(BuildContext context) {
  return FutureBuilder(
    future: _loadSubTitle(),
    builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Column(
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
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}
