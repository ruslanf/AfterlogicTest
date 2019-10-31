import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:flutter/material.dart';

import '../contact_details.dart';

class MainListView extends StatelessWidget {
  final List<UserInfo> listContacts;
  MainListView({Key key, @required this.listContacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: listContacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text((listContacts[index].fullName.isEmpty)
                ? NO_NAME
                : listContacts[index].fullName),
            subtitle: Text((listContacts[index].personalEmail.isEmpty)
                ? NO_EMAIL
                : listContacts[index].personalEmail),
            onTap: () {
              _openContactDetails(context, listContacts[index]);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  _openContactDetails(BuildContext context, UserInfo _userInfo) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactDetails(userInfo: _userInfo,)));
  }
}
