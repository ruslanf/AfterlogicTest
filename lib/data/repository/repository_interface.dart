class StorageTokenInterface {
  getToken() {}
  void saveToken(String _token) {}
}

class StorageCTagInterface {
  getPersonalCTag() {}
  void storePersonalCTag(int _cTag) {}
  getTeamCtag() {}
  void storeTeamCTag(int _cTag) {}
  compareCTag(int _newCTag, int _oldCTag) {}
}
