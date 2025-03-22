class Token {

  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  Token.fromJson(dynamic json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    return map;
  }
}
