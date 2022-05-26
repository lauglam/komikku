import 'package:intl/intl.dart';

String? formatDate(DateTime? date) {
  return date == null ? null : DateFormat('yyyy-MM-ddTHH:MM:SS').format(date);
}

DateTime parseDate(String inputString) {
  return DateFormat('yyyy-MM-ddTHH:MM:SS').parse(inputString);
}
