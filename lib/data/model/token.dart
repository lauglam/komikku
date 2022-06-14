import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Token extends HiveObject {
  @HiveField(0)
  String value;

  @HiveField(1)
  DateTime expire;

  Token({required this.value, required this.expire});
}
