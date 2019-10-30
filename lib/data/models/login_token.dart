class LoginToken {
  final Map result;
  final AuthToken token;

  LoginToken({this.result, this.token});

  factory LoginToken.fromJson(Map<String, dynamic> json) {
    return LoginToken(
      result: json['Result'],
      token: AuthToken.fromJson(json['Result']),
    );
  }
}

class AuthToken {
  final String authToken;

  AuthToken({this.authToken});

  AuthToken.fromJson(Map<String, dynamic> json) : authToken = json['AuthToken'];
  
  Map<String, dynamic> toJson() => {
        'AuthToken': authToken,
      };
}