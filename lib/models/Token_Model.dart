class Token {
  final String login;
  final String type;
  final String applicationToken;

  Token(
      {required this.login,
      required this.type,
      required this.applicationToken});

  factory Token.fromJson(Map<String, dynamic> JsonData) {
    return Token(
        login: JsonData['login'],
        type: JsonData['class'],
        applicationToken: JsonData['applicationToken']);
  }
}
