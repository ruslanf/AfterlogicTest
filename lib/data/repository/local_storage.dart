import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageInterface {
  final String _host = "host";
  final String _email = "email";

  @override
  Future<String> getEMail() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_email) ?? "";
  }

  @override
  Future<String> getHost() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(_host) ?? DEFAULT_HOST;
  }

  @override
  Future<bool> saveEMail(String email) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(_email, email);
  }

  @override
  Future<bool> saveHost(String host) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.setString(_host, host);
  }  
}