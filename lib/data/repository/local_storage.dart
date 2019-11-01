import 'package:afterlogic_test/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final String _host = "host";
  final String _email = "email";

  Future<String> getHost() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_host) ?? DEFAULT_HOST;
  }

  Future<bool> saveHost(String host) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(_host, host);
  }

  Future<String> getEMail() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_email) ?? "";
  }

  Future<bool> saveEMail(String email) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(_email, email);
  }
}