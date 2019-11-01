class ResponseFromServer {
  final int authenticatedUserId;
  final int errorCode;

  ResponseFromServer({this.authenticatedUserId, this.errorCode});

  factory ResponseFromServer.fromJson(Map<String, dynamic> json) {
    return ResponseFromServer(
      authenticatedUserId: json['AuthenticatedUserId'],
      errorCode: json['ErrorCode']
    );
  }
}