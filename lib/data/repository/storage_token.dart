import 'package:afterlogic_test/data/repository/repository_interface.dart';
import 'package:afterlogic_test/common/globals.dart' as global;

class StorageToken implements StorageTokenInterface {
  @override
  getToken() {
    return global.token;
  }

  @override
  void saveToken(String _token) {
    global.token = _token;
  }
}
