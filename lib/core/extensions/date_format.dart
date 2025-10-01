import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return DateFormat('yyyy-MM-dd', 'en').format(this);
  }
  String toFormattedDateTimeString() {
    return DateFormat('yyyy-MM-dd hh:mm a', 'en').format(this);
  }

  String toFormattedEnString() {
    return DateFormat('yyyy-MM-dd', 'en').format(this);
  }
}
