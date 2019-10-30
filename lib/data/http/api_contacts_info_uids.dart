import 'dart:async';
import 'dart:convert';
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:http/http.dart' as http;
import 'package:afterlogic_test/common/globals.dart' as global;

Future<ContactInfoUid> getContactsInfoUIDS(String token, String id, List<String> uids) async {
  Map<String, String> _headers = {'Authorization': 'Bearer $token'};

  Map _data = {
    'Module': 'Contacts',
    'Method': 'GetContactsByUids',
    'Parameters': jsonEncode({'Storage': '$id', 'Uids': uids}),
  };

  return await http
      .post(global.apiUrl, headers: _headers, body: _data)
      .then((http.Response response) {
    if (response.statusCode != 200) {
      print("Error! Status code -> ${response.statusCode}");
    }
    print("Response body -> ${response.body}");
    return ContactInfoUid.fromJson(json.decode(response.body));
  });
}
