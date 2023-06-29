import 'package:cash_recorderv2/database/database.isar.dart';
import 'package:cash_recorderv2/features/bill/bill_bloc.dart';
import 'package:cash_recorderv2/repository/db_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BillDialog extends StatelessWidget {
  BillDialog({super.key});
  final ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Bill'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: ctrl,
            autofocus:
                true, // Add this line to focus on the text field from the start
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final bill = Bill();
            bill.billName = ctrl.text;

            final b = context.read<BillCubit>().bill;

            bill.parentBill.value = b;

            Get.find<DatabaseRepository>().addBillWithParent(bill);

            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
