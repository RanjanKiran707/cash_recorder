import 'dart:async';

import 'package:cash_recorderv2/core/util/db_ext.dart';
import 'package:cash_recorderv2/database/database.isar.dart';
import 'package:isar/isar.dart';

class DatabaseRepository {
  Isar isarInstance;

  DatabaseRepository(this.isarInstance);

  Stream<List<Bill>> get billStream => isarInstance.bills
      .filter()
      .parentBillIsNull()
      .watch(fireImmediately: true);

  Future<void> addBill(Bill bill) async {
    await isarInstance.writeTxn(() async {
      return isarInstance.bills.put(bill);
    });
  }

  Future<void> addBillWithParent(Bill bill) async {
    await isarInstance.writeTxn(() async {
      await isarInstance.bills.put(bill);
      await bill.parentBill.save();
    });
  }

  Stream<Bill> getBillContent(Id id) {
    StreamController<Bill> billStreamController = StreamController<Bill>();

    isarInstance.bills
        .filter()
        .idEqualTo(id)
        .watch(fireImmediately: true)
        .listen(
      (event) {
        if (event.isEmpty) return;
        billStreamController.add(event.first);
      },
      onDone: () {
        billStreamController.close();
      },
    );
    return billStreamController.stream;
  }

  Stream<List<Bill>> getSubBills(Id id) {
    StreamController<List<Bill>> subBillStreamController =
        StreamController<List<Bill>>();

    isarInstance.bills
        .filter()
        .parentBill((q) => q.idEqualTo(id))
        .watch(fireImmediately: true)
        .listen(
      (event) {
        subBillStreamController.add(event);
      },
      onDone: () {
        subBillStreamController.close();
      },
    );
    return subBillStreamController.stream;
  }

  addParticular(Id id, Particular particular) {
    isarInstance.writeTxn(() async {
      return isarInstance.bills.where().idEqualTo(id).findFirst().then((bill) {
        bill!.content = [...bill.content, particular];
        return isarInstance.bills.put(bill);
      });
    });
  }

  Future<void> deleteParticular(Id id, Particular particular) async {
    await isarInstance.writeTxn(() async {
      return isarInstance.bills.where().idEqualTo(id).findFirst().then((bill) {
        final contentList = List<Particular>.from(bill!.content);
        contentList.removeWhere(
          (element) => element.isEqual(particular),
        );
        bill.content = contentList;
        return isarInstance.bills.put(bill);
      });
    });
  }

  Future<int> getDescendants(Id id) async {
    int count = 0;
    await isarInstance.bills
        .filter()
        .parentBill((q) => q.idEqualTo(id))
        .build()
        .findAll()
        .then((value) async {
      count += value.length;
      for (final bill in value) {
        count += await getDescendants(bill.id);
      }
    });
    return count;
  }

  Future<void> deleteBill(Id id) async {
    await isarInstance.writeTxn(() async {
      return await _deleteBillRecursive(id);
    });
  }

  Future<void> _deleteBillRecursive(Id id) async {
    return isarInstance.bills
        .where()
        .idEqualTo(id)
        .findFirst()
        .then((bill) async {
      final childBills = await isarInstance.bills
          .filter()
          .parentBill((q) => q.idEqualTo(id))
          .build()
          .findAll();

      for (final childBill in childBills) {
        await _deleteBillRecursive(childBill.id);
      }

      await isarInstance.bills.delete(bill!.id);
    });
  }
}
