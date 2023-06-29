import 'dart:async';

import 'package:cash_recorderv2/core/util/db_ext.dart';
import 'package:cash_recorderv2/core/util/format_ext.dart';
import 'package:cash_recorderv2/core/util/widget_ext.dart';
import 'package:cash_recorderv2/database/database.isar.dart';
import 'package:cash_recorderv2/features/bill/bill_bloc.dart';
import 'package:cash_recorderv2/features/bill/widgets/bill_dialog_widget.dart';
import 'package:cash_recorderv2/features/bill/widgets/particular_dialog_widget.dart';
import 'package:cash_recorderv2/features/home/home_view.dart';
import 'package:cash_recorderv2/repository/db_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BillView extends StatelessWidget {
  const BillView({super.key, required this.bill});

  final Bill bill;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillCubit(
        Get.find(),
        bill,
      ),
      child: const BillPage(),
    );
  }
}

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final billState = context.watch<BillCubit>().state;
    if (billState.status == BillStatus.loading) {
      return const SafeArea(
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: FittedBox(
            child: Text(
              '${context.read<BillCubit>().bill.parentString}bill',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.find<DatabaseRepository>()
                    .getDescendants(context.read<BillCubit>().bill.id)
                    .then((value) {
                  AlertDialog(
                    title: const Text('Delete Bill'),
                    content: Text(
                      'Are you sure you want to delete this bill and its $value sub bills?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.find<DatabaseRepository>()
                              .deleteBill(context.read<BillCubit>().bill.id);

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ).showDialogExt(context: context);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: const [
              Tab(text: 'Records'),
              Tab(text: 'Sub Bills'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            billState.particulars.isEmpty
                ? const Center(
                    child: Text(
                      "Empty",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      TotalWidget(totalAmount: billState.totalAmount),
                      SliverList.builder(
                        itemBuilder: (context, index) {
                          final item = billState.particulars[index];
                          return RecordWidget(particular: item);
                        },
                        itemCount: billState.particulars.length,
                      ),
                      SliverToBoxAdapter(
                        child: 60.hBox,
                      )
                    ],
                  ),
            billState.subBills.isEmpty
                ? const Center(
                    child: Text(
                      "Empty",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverList.builder(
                        itemBuilder: (context, index) {
                          return BillWidget(bill: billState.subBills[index]);
                        },
                        itemCount: billState.subBills.length,
                      )
                    ],
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text("Add Record"),
              onPressed: () {
                ParticularDialog()
                    .showDialogBlocExt<BillCubit>(context: context);
              },
              icon: const Icon(Icons.add),
            ),
            10.wBox,
            FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text("Add Bill"),
              onPressed: () {
                BillDialog().showDialogBlocExt<BillCubit>(context: context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    super.key,
    required this.totalAmount,
  });

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const Text(
              "Total",
              style: TextStyle(fontSize: 15),
            ),
            5.hBox,
            Text(
              totalAmount.indianFormat,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordWidget extends StatelessWidget {
  const RecordWidget({
    super.key,
    required this.particular,
  });
  final Particular particular;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        final id = context.read<BillCubit>().bill.id;
        await Get.find<DatabaseRepository>().deleteParticular(id, particular);
      },
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        final Completer<bool> completer = Completer<bool>();
        AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Do you want to delete this record?"),
          actions: [
            TextButton(
              onPressed: () {
                completer.complete(false);
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                completer.complete(true);
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        ).showDialogBlocExt<BillCubit>(context: context);

        return completer.future;
      },
      child: ListTile(
        title: Text(particular.particularName),
        subtitle: Text(particular.amount.indianFormat),
      ),
    );
  }
}
