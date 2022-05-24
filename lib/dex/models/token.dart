/// 用户令牌
class Token {
  // 有效期15分钟
  String session;

  // 有效期30天
  String refresh;

  Token({
    required this.session,
    required this.refresh,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        session: json['session'] as String,
        refresh: json['refresh'] as String,
      );

  Map<String, dynamic> toJson() => {
        'session': session,
        'refresh': refresh,
      };
}
