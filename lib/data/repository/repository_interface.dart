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
  getFromMap(String _key) {}
  void putIntoMap(String _key, List<String> _uids) {}
  compareETag(String _eTag) {}
}

class StorageUidsInterface {
  getUids() {}
  void storeUids(String _uids) {}
  getFromMap(String _key) {}
  void putIntoMap(String _key, List<String> _uids) {}
  compareUids(String _uids) {}
}