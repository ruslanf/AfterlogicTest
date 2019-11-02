import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:afterlogic_test/common/globals.dart' as global;

class StorageETag implements StorageETagInterface {
  @override
  compareETag(String _eTag) {
    return (global.eTags.contains(_eTag)) ? true : false;
  }

  @override
  getETagList() {
    return global.eTags;
  }

  @override
  void storeETagList(String _eTag) {
    if (!global.eTags.contains(_eTag)) {
      global.eTags.add(_eTag);
    }
  }
}
