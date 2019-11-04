class ApiLoginInterface {
  Future postLogin(String host, String email, String password) async {}
}

class ApiContactStoragesInterface {
  Future getContactStorages(String token) async {}
}

class ApiContactsInfoInterface {
  Future getContactsInfo(String token, String id) async {}
}

class ApiContactsInfoUidsInterface {
  Future getContactsInfoUIDS(String token, String id, List<String> uids) async {}
}