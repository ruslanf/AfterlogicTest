import 'dart:async';
import 'dart:convert';
import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/http/api_interfaces.dart';
import 'package:afterlogic_test/data/models/error_code.dart';
import 'package:afterlogic_test/data/models/login_token.dart';
import 'package:http/http.dart' as http;
import 'package:afterlogic_test/common/globals.dart' as global;

class ApiLogin implements ApiLoginInterface {
  @override
  Future postLogin(String host, String email, String password) async {
    Map data = {
      'Module': 'Core',
      'Method': 'Login',
      'Parameters': json.encode({'Login': '$email', 'Password': '$password'})
    };

    String _apiUrl = "$API_URL_START$host$API_URL_END";
    global.apiUrl = _apiUrl;

    return await http.post(_apiUrl, body: data).then((http.Response response) {
      if (response.statusCode != 200) {
        print("Error! Status code -> ${response.statusCode}");
      }
      print("Response body -> ${response.body}");
      try {
        return LoginToken.fromJson(json.decode(response.body));
      } on NoSuchMethodError catch (_) {
        return ResponseFromServer.fromJson(json.decode(response.body));
      }
    });
  }
}