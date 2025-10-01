import 'package:member360/core/extensions/date_format.dart';
import 'package:member360/core/localization/translate.dart';
import 'package:intl/intl.dart' as international;

extension StringExtension on String? {
  /// Return true only if
  ///
  /// value is not empty && value is not null
  bool get isNotBlank => this?.isNotEmpty == true;

  bool get isBlank => this == null || (this ?? '').isEmpty;

  bool get isRTL => international.Bidi.detectRtlDirectionality(this!);

  String formatTimeStampDate() {
    if (this == null) return '';
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(this!) * 1000);
    int diff = DateTime.now().difference(date).inDays;
    if (diff == 0) {
      return Translate.s.today;
    } else if (diff == 1) {
      return Translate.s.yesterday;
    } else if (diff == -1) {
      return Translate.s.tomorrow;
    }
    return date.toFormattedString();
  }

  String formatDateTimeStampDate() {
    if (this == null) return '';
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(this!) * 1000);
    int diff = DateTime.now().difference(date).inDays;
    if (diff == 0) {
      return Translate.s.today;
    } else if (diff == 1) {
      return Translate.s.yesterday;
    } else if (diff == -1) {
      return Translate.s.tomorrow;
    }
    return date.toFormattedDateTimeString();
  }
}
