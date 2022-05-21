import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format() => DateFormat('YYYY-MM-DDTHH:MM:SS').format(this);
}

extension StringExtension on String {
  DateTime parse() => DateFormat('YYYY-MM-DDTHH:MM:SS').parse(this);
}
