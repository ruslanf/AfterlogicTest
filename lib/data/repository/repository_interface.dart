class LocalStorageInterface {
  getHost() async {}
  saveHost(String host) async {}
  getEMail() async {}
  saveEMail(String email) async {}
}

class StorageTokenInterface {
  getToken() {}
  void saveToken(String _token) {}
}

class StorageCTagInterface {
  getPersonalCTag() {}
  void storePersonalCTag(int _cTag) {}
  getTeamCtag() {}
  void storeTeamCTag(int _cTag) {}
  comparePersonalCTag(int _newCTag) {}
  compareTeamCTag(int _newCTag) {}
}

class StorageETagInterface {
  getETagList() {}
  void storeETagList(String _eTag) {}
  compareETag(String _eTag) {}
}