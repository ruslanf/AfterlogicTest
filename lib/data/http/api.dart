import 'dart:convert';
import 'package:afterlogic_test/common/globals.dart' as global;
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:dio/dio.dart';

Future<ContactInfoUid> diogetContactsInfoUIDS(String token, String id, List<String> uids) async {
  var dio = Dio();
  Response response;
  var _headers = {'Authorization': 'Bearer $token'};
  var _data = {
    "Module": "Contacts",
    "Method": "GetContactsByUids",
    "Parameters": jsonEncode({"Storage": "$id", "Uids": uids}),
  };
  dio.options.headers = _headers;
  dio.options.queryParameters = _data;
  print("Dio started...");
  print("Headers -> $_headers");
  print("Parameters -> $_data");

  // response = await dio.post(global.apiUrl, queryParameters: _data, options: Options(headers: _headers));
  response = await dio.post(global.apiUrl);
  if (response.statusCode != 200) {
      print("Error! Status code -> ${response.statusCode}");
    }
    print("Response body -> ${response.data}");
    return ContactInfoUid.fromJson(json.decode(response.data));
}