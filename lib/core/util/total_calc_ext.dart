import 'package:cash_recorderv2/database/database.isar.dart';

extension BillListExt on List<Bill> {
  double get total {
    return fold<double>(
      0,
      (previousValue, element) =>
          previousValue +
          element.content.fold(
            0,
            (previousValue, element1) => previousValue + element1.amount,
          ),
    );
  }
}

extension ParticularListExt on List<Particular> {
  double get total {
    return fold<double>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }
}
