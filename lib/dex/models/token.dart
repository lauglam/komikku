import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

/// 用户令牌
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Token {
  /// 会话令牌
  /// 有效期15分钟
  final String session;

  /// 刷新令牌
  /// 有效期30天
  final String refresh;

  Token({
    required this.session,
    required this.refresh,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
