import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:afterlogic_test/common/globals.dart' as global;

class StorageCTag implements StorageCTagInterface {
  @override
  compareCTag(int _newCTag, int _oldCTag) {
    return (_newCTag == _oldCTag) ? true : false;
  }

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
}
