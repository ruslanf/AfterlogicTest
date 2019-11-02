import 'dart:async';
import 'dart:convert';
import 'package:afterlogic_test/data/http/api_interfaces.dart';
import 'package:http/http.dart' as http;
import 'package:afterlogic_test/data/models/storages.dart';
import 'package:afterlogic_test/common/globals.dart' as global;

class ApiContactStorages implements ApiContactStoragesInterface {
  @override
  Future<Storages> getContactStorages(String token) async {
    Map<String, String> _headers = {'Authorization': 'Bearer $token'};
    Map _data = {'Module': 'Contacts', 'Method': 'GetContactStorages'};
    return await http
        .post(global.apiUrl, headers: _headers, body: _data)
        .then((http.Response response) {
      if (response.statusCode != 200) {
        print("Error! Status code -> ${response.statusCode}");
      }
      print("Response body -> ${response.body}");
      return Storages.fromJson(json.decode(response.body));
    });
  }
}