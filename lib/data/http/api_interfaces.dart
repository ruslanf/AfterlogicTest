import 'package:afterlogic_test/data/models/contacts_info.dart';
import 'package:afterlogic_test/data/models/contacts_info_uids.dart';
import 'package:afterlogic_test/data/models/storages.dart';

class ApiLoginInterface {
  Future postLogin(String host, String email, String password) async {}
}

class ApiContactStoragesInterface {
  Future<Storages> getContactStorages(String token) async {}
}

class ApiContactsInfoInterface {
  Future<ContactsInfo> getContactsInfo(String token, String id) async {}
}

class ApiContactsInfoUidsInterface {
  Future<ContactInfoUid> getContactsInfoUIDS(String token, String id, List<String> uids) async {}
}