import 'package:isar/isar.dart';

part 'database.isar.g.dart';

@collection
class Bill {
  Id id = Isar.autoIncrement;

  final parentBill = IsarLink<Bill>();

  late String billName;

  List<Particular> content = [];
}

@embedded
class Particular {
  late String particularName;
  late double amount;
  late DateTime date;
}
