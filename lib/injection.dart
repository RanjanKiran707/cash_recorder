import 'package:cash_recorderv2/database/database.isar.dart';
import 'package:cash_recorderv2/repository/db_repository.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> getIsarInstance() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [BillSchema],
    directory: dir.path,
  );
}

Future<void> dependencyInjection() async {
  final isar = await getIsarInstance();

  Get.put(DatabaseRepository(isar));
}
