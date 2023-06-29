import 'dart:async';

import 'package:cash_recorderv2/database/database.isar.dart';
import 'package:cash_recorderv2/repository/db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cash_recorderv2/core/util/total_calc_ext.dart';

enum BillStatus {
  loading,
  loaded,
}

class BillState {
  final BillStatus status;
  final List<Particular> particulars;
  final List<Bill> subBills;
  final double totalAmount;

  BillState({
    this.status = BillStatus.loading,
    this.particulars = const [],
    this.subBills = const [],
    this.totalAmount = 0,
  });

  BillState.initial()
      : status = BillStatus.loading,
        particulars = const [],
        subBills = const [],
        totalAmount = 0;

  BillState copyWith({
    BillStatus? status,
    List<Particular>? particulars,
    List<Bill>? subBills,
    double? totalAmount,
  }) {
    return BillState(
      status: status ?? this.status,
      particulars: particulars ?? this.particulars,
      subBills: subBills ?? this.subBills,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class BillCubit extends Cubit<BillState> {
  final DatabaseRepository databaseRepository;
  final Bill bill;
  StreamSubscription? _subscription;
  BillCubit(this.databaseRepository, this.bill) : super(BillState.initial()) {
    final contentStream = databaseRepository.getBillContent(bill.id);

    final subBillStream = databaseRepository.getSubBills(bill.id);

    _subscription =
        Rx.combineLatest2(contentStream, subBillStream, (a, b) => (a, b))
            .listen(
      (event) {
        emit(
          state.copyWith(
            status: BillStatus.loaded,
            particulars: event.$1.content,
            subBills: event.$2,
            totalAmount: event.$1.content.total,
          ),
        );
      },
      onDone: () {},
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
