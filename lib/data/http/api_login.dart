import 'dart:async';
import 'dart:convert';
import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/models/error_code.dart';
import 'package:afterlogic_test/data/models/login_token.dart';
import 'package:http/http.dart' as http;
import 'package:afterlogic_test/common/globals.dart' as global;

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
      print("Answer");
      var answer = LoginToken.fromJson(json.decode(response.body));
      return answer;
    } on NoSuchMethodError catch (_) {
      print("Exception");
      return ResponseFromServer.fromJson(json.decode(response.body));
    }

    // if ((LoginToken.fromJson(json.decode(response.body)).authenticatedUserId != 0)
    // return LoginToken.fromJson(json.decode(response.body));
    // return (answer.authenticatedUserId != 0) ? answer :
  });
}
