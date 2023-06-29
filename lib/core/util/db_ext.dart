import 'package:cash_recorderv2/database/database.isar.dart';

extension Equality on Particular {
  bool isEqual(Particular particular) {
    return particularName == particular.particularName &&
        amount == particular.amount &&
        date == particular.date;
  }
}

extension ParentString on Bill {
  String get parentString {
    Bill? temp = this;
    String ans = '';
    while (temp != null) {
      ans = '> ${temp.billName} $ans';
      temp = temp.parentBill.value;
    }
    ans = ans.substring(1);
    return ans;
  }
}
