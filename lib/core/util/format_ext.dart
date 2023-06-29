import 'package:intl/intl.dart';

extension IndianFormat on double {
  String get indianFormat {
    final formatter =
        NumberFormat.simpleCurrency(locale: "en_IN", decimalDigits: 0);
    return formatter.format(this);
  }
}
