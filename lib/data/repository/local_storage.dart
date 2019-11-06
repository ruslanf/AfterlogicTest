import 'package:afterlogic_test/common/constants.dart';
import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageInterface {
  final _host = "host";
  final _email = "email";
  final _pCTag = "pCTag";
  final _tCTag = "tCTag";

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

  @override
  Future<int> getPCTag() async {
    return await SharedPreferences.getInstance().then((onValue) {
      return (onValue != null) ? onValue.getInt(_pCTag) : 0; 
    });
  }

  @override
  Future<int> getTCTag() async {
    return await SharedPreferences.getInstance().then((onValue) {
      return (onValue != null) ? onValue.getInt(_tCTag) : 0; 
    });
  }

  @override
  Future<bool> savePCtag(int pCTag) async {
    return await SharedPreferences.getInstance().then((onValue) {
      return onValue.setInt(_email, pCTag);
    });
  }

  @override
  Future<bool> saveTCtag(int tCTag) async {
    return await SharedPreferences.getInstance().then((onValue) {
      return onValue.setInt(_email, tCTag);
    });
  }  
}