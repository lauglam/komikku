import 'package:intl/intl.dart';

String? formatDate(DateTime? date) {
  return date == null ? null : DateFormat('YYYY-MM-DDTHH:MM:SS').format(date);
}

DateTime parseDate(String inputString) {
  return DateFormat('YYYY-MM-DDTHH:MM:SS').parse(inputString);
}
