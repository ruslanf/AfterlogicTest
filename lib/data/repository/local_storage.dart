import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageInterface {
  final String _host = "host";
  final String _email = "email";

  @override
  Future<String> getEMail() async {
    return await SharedPreferences.getInstance().then((onValue) {
      return (onValue != null) ? onValue.getString(_email) : "";
    });
  }

  @override
  Future<String> getHost() async {
    return await SharedPreferences.getInstance().then((onValue) {
      return (onValue != null) ? onValue.getString(_host) : DEFAULT_HOST; 
    });
  }

  @override
  Future<bool> saveEMail(String email) async {
    return await SharedPreferences.getInstance().then((onValue) {
      return onValue.setString(_email, email);
    });
  }

  @override
  Future<bool> saveHost(String host) async {
    return await SharedPreferences.getInstance().then((onValue) {
      return onValue.setString(_host, host);
    });
  }  
}