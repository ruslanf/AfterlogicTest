import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:afterlogic_test/common/globals.dart' as global;

class StorageUids implements StorageUidsInterface {
  @override
  compareUids(String _uids) {
    return (global.uIds.contains(_uids)) ? true : false;
  }

  @override
  getUids() {
    return global.uIds;
  }

  @override
  void storeUids(String _uids) {
    if (!global.uIds.contains(_uids)) {
      global.uIds.add(_uids);
    }
  }

  @override
  getFromMap(String _key) {
    return global.mapUids[_key];
  }

  @override
  void putIntoMap(String _key, List<String> _uids) {
    global.mapUids[_key] = _uids;
  }
}