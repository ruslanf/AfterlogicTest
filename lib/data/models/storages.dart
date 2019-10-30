class Storages {
  final int authenticatedUserId;
  final List<StorageData> result;

  Storages({this.authenticatedUserId, this.result});

  factory Storages.fromJson(Map<String, dynamic> json) {
    var data = json['Result'] as List;
    List<StorageData> storageData = data.map((i) => StorageData.fromJson(i)).toList();
    return Storages(
      authenticatedUserId: json['AuthenticatedUserId'],
      result: storageData,
    );
  }
}

class StorageData {
  final String id;
  final String name;
  final int cTag;

  StorageData(
      {this.id,
      this.name,
      this.cTag});

  StorageData.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        name = json['Name'],
        cTag = json['CTag'];
}
