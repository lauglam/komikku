/// 刷新令牌
class Refresh {
  String token;
  DateTime expire;

  Refresh({
    required this.token,
    required this.expire,
  });

  factory Refresh.fromJson(Map<String, dynamic> json) => Refresh(
    token: json['token'] as String,
    expire: DateTime.parse(json['expire'] as String),
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'expire': expire.toIso8601String(),
  };
}