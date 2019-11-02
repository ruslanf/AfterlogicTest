import 'dart:async';
import 'dart:convert';
import 'package:afterlogic_test/data/http/api_interfaces.dart';
import 'package:afterlogic_test/data/models/contacts_info.dart';
import 'package:http/http.dart' as http;
import 'package:afterlogic_test/common/globals.dart' as global;

class ApiContactsInfo implements ApiContactsInfoInterface {
  @override
  Future<ContactsInfo> getContactsInfo(String token, String id) async {
    Map<String, String> _headers = {'Authorization': 'Bearer $token'};

    Map _data = {
      'Module': 'Contacts',
      'Method': 'GetContactsInfo',
      'Parameters': jsonEncode({'Storage': '$id'}),
    };

    return await http
        .post(global.apiUrl, headers: _headers, body: _data)
        .then((http.Response response) {
      if (response.statusCode != 200) {
        print("Error! Status code -> ${response.statusCode}");
      }
      print("Response body -> ${response.body}");
      return ContactsInfo.fromJson(json.decode(response.body));
    });
  }
}