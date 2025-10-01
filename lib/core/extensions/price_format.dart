import 'package:intl/intl.dart';

extension PriceFormat on String {
  String get priceFormat {
    if (this == "0" || this == "0.00"||this=="") {
      return "0.00";
    }
    final NumberFormat usCurrency = NumberFormat('#,##0', 'en_US');
    return usCurrency.format(double.parse(this));
  }


}