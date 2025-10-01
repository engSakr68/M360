// ignore_for_file: avoid_dynamic_calls

import 'package:collection/collection.dart';

extension EnumFactoryExtension on List {
  E? enumFactory<E>(val) {
    return firstWhereOrNull((e) => e.value == val);
  }
}
