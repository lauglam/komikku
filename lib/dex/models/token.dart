/// 用户令牌
class Token {
  // 有效期15分钟
  final String session;

  // 有效期30天
  final String refresh;

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
