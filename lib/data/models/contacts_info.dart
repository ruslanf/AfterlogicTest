class ContactsInfo {
  final int authenticatedUserId;
  final Result result;

  ContactsInfo({this.authenticatedUserId, this.result});

  factory ContactsInfo.fromJson(Map<String, dynamic> json) {
    return ContactsInfo(
      authenticatedUserId: json['AuthenticatedUserId'],
      result: Result.fromJson(json['Result']),
    );
  }
}

class Result {
  final int cTag;
  final List<Info> info;

  Result({this.cTag, this.info});

  factory Result.fromJson(Map<String, dynamic> json) {
    var data = json['Info'] as List;
    List<Info> infoList = data.map((i) => Info.fromJson(i)).toList();
    return Result(
      cTag: json['CTag'],
      info: infoList,
    );
  }
}

class Info {
  final String uUID;
  final String eTag;

  Info(
      {this.uUID,
      this.eTag});

  Info.fromJson(Map<String, dynamic> json)
      : uUID = json['UUID'],
        eTag = json['ETag'];
}
