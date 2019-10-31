class ContactInfoUid {
  final int authenticatedUserId;
  final List<UserInfo> result;

  ContactInfoUid({this.authenticatedUserId, this.result});

  factory ContactInfoUid.fromJson(Map<String, dynamic> json) {
    var data = json['Result'] as List;
    List<UserInfo> _data = data.map((i) => UserInfo.fromJson(i)).toList();
    return ContactInfoUid(
      authenticatedUserId: json['AuthenticatedUserId'],
      result: _data,
    );
  }
}

class UserInfo {
  final String personalEmail;
  final String eTag;
  final String fullName;
  final String skype;
  final String facebook;
  final int primaryAdress;
  final int primaryPhone;
  final String personalAddress;

  UserInfo(
      {this.eTag,
      this.fullName,
      this.personalEmail,
      this.personalAddress,
      this.primaryPhone,
      this.primaryAdress,
      this.skype,
      this.facebook});

  UserInfo.fromJson(Map<String, dynamic> json)
      : eTag = json['ETag'],
        fullName = json['FullName'],
        personalEmail = json['PersonalEmail'],
        personalAddress = json['PersonalAddress'],
        primaryPhone = json['PrimaryPhone'],
        primaryAdress = json['PrimaryAdress'],
        skype = json['Skype'],
        facebook = json['Facebook'];
}
