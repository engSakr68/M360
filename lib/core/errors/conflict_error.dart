import 'package:member360/core/localization/translate.dart';

import 'base_error.dart';

class ConflictError extends BaseError {
  ConflictError() : super(Translate.s.error_conflict);
}
