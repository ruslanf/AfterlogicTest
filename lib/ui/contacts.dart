import 'dart:io';

import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/http/api_contacts_info.dart';
import 'package:afterlogic_test/data/http/api_contacts_info_uids.dart';
import 'package:afterlogic_test/data/http/api_contacts_storages.dart';
import 'package:afterlogic_test/data/models/contacts_info.dart';
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:afterlogic_test/data/repository/storage_ctag.dart';
import 'package:afterlogic_test/data/repository/storage_etag.dart';
import 'package:afterlogic_test/data/repository/storage_token.dart';
import 'package:afterlogic_test/data/repository/storage_uids.dart';
import 'package:afterlogic_test/ui/view/main_listview.dart';
import 'package:flutter/material.dart';

const ID_PERSONAL = "personal";
const ID_TEAM = "team";

class Contacts extends StatefulWidget {
  Contacts({Key key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  void initState() {
    _storageId = ID_PERSONAL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _futureLoad(context),
        actions: <Widget>[
          IconButton(
            tooltip: TITLE_REFRESH_BUTTON,
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureListLoad(context);
              });
            },
          ),
          IconButton(
            tooltip: TITLE_EXIT_BUTTON,
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
              child: Text(DRAWER_TITLE),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
                title: Text(TITLE_PERSONAL),
                onTap: () {
                  setState(() {
                    Navigator.pop(context, true);
                    _storageId = ID_PERSONAL;
                    _changeList(_storageId);
                  });
                }),
            Divider(
              height: 2.0,
            ),
            ListTile(
                title: Text(TITLE_TEAM),
                onTap: () {
                  setState(() {
                    Navigator.pop(context, true);
                    _storageId = ID_TEAM;
                    _changeList(_storageId);
                  });
                }),
            Divider(
              height: 2.0,
            )
          ],
        ),
      ),
    );
  }
}

bool _isCTagChanged;
final _apiContactStorages = ApiContactStorages();
final _apiContactsInfo = ApiContactsInfo();
final _apiContactsInfoUids = ApiContactsInfoUids();
final _storageToken = StorageToken();
final _storageCTag = StorageCTag();
final _storageETag = StorageETag();
final _storageUids = StorageUids();
var subTitle = "";
List<UserInfo> _listPersonalContacts = List();
List<UserInfo> _listTeamContacts = List();

List<UserInfo> listContactsInfo = List();
String _storageId;

_startPage() async {
  await _getCTagFromServer();

  if (_isCTagChanged) {
    await _getContactsInfoFromServer(ID_PERSONAL);
    await _getContactsInfoUids(
        ID_PERSONAL, _storageUids.getFromMap(ID_PERSONAL));

    await _showListContacts(ID_PERSONAL);

    await _getContactsInfoFromServer(ID_TEAM);
    await _getContactsInfoUids(ID_TEAM, _storageUids.getFromMap(ID_TEAM));
  }
}

_getCTagFromServer() async {
  return await _apiContactStorages
      .getContactStorages(_storageToken.getToken())
      .then((_stors) {
    var _pCTag = 0;
    var _tCTag = 0;
    if (_storageCTag.getPersonalCTag() == 0) {
      _stors.result.forEach((f) => (f.id == ID_PERSONAL)
          ? _storageCTag.storePersonalCTag(f.cTag)
          : null);
    } else {
      _pCTag = _storageCTag.getPersonalCTag();
    }
    if (_storageCTag.getTeamCtag() == 0) {
      _stors.result.forEach(
          (f) => (f.id == ID_TEAM) ? _storageCTag.storeTeamCTag(f.cTag) : null);
    } else {
      _tCTag = _storageCTag.getTeamCtag();
    }
    subTitle = _stors.result.firstWhere((f) => f.id == ID_PERSONAL).name;
    if (!_storageCTag.comparePersonalCTag(_pCTag) ||
        !_storageCTag.compareTeamCTag(_tCTag)) {
      print("CTag changed...");
      _isCTagChanged = true;
    } else {
      print("CTag not changed");
      _isCTagChanged = false;
    }
  });
}

_getContactsInfoFromServer(String _id) async {
  return await _apiContactsInfo
      .getContactsInfo(_storageToken.getToken(), _id)
      .then((_contactsInfo) {
    _storageUids.putIntoMap(_id, _getUids(_contactsInfo));
    _storageETag.putIntoMap(_id, _getETags(_contactsInfo));
  });
}

_getContactsInfoUids(String _id, List<String> _uids) async {
  return await _apiContactsInfoUids
      .getContactsInfoUIDS(_storageToken.getToken(), _id, _uids)
      .then((_infoUids) {
    switch (_id) {
      case ID_PERSONAL:
        _listPersonalContacts = _infoUids.result;
        break;
      case ID_TEAM:
        _listTeamContacts = _infoUids.result;
        break;
    }
  });
}

_getUids(ContactsInfo _info) {
  List<String> _uids = List();
  _info.result.info.forEach((f) => _uids.add(f.uUID));
  return _uids;
}

_getETags(ContactsInfo _info) {
  List<String> _eTags = List();
  _info.result.info.forEach((f) => _eTags.add(f.eTag));
  return _eTags;
}

_showListContacts(String _id) {
  switch (_id) {
    case ID_PERSONAL:
      listContactsInfo = _listPersonalContacts;
      subTitle = TITLE_PERSONAL;
      break;
    case ID_TEAM:
      listContactsInfo = _listTeamContacts;
      subTitle = TITLE_TEAM;
      break;
  }
}

_changeList(String _id) async {
  _showListContacts(_id);
}

Widget _futureListLoad(BuildContext context) {
  return FutureBuilder(
    future: _startPage(),
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
    future: _changeList(_storageId),
    builder: (context, snapshot) {
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
