import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:afterlogic_test/common/globals.dart' as global;

class StorageCTag implements StorageCTagInterface {
  @override
  getPersonalCTag() {
    return global.pCTag;
  }

  @override
  getTeamCtag() {
    return global.tCTag;
  }

  @override
  void storePersonalCTag(int _cTag) {
    global.pCTag = _cTag;
  }

  @override
  void storeTeamCTag(int _cTag) {
    global.tCTag = _cTag;
  }

  @override
  comparePersonalCTag(int _newCTag) {
    return (_newCTag == global.pCTag) ? true : false;
  }

  @override
  compareTeamCTag(int _newCTag) {
    return (_newCTag == global.tCTag) ? true : false;
  }
}
