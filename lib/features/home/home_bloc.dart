import 'dart:async';

import 'package:cash_recorderv2/database/database.isar.dart';
import 'package:cash_recorderv2/repository/db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeStatus {
  loading,
  loaded,
}

class HomeState {
  final HomeStatus status;
  final List<Bill> bills;

  HomeState({this.status = HomeStatus.loading, this.bills = const []});

  HomeState.initial()
      : status = HomeStatus.loading,
        bills = const [];

  HomeState copyWith({HomeStatus? status, List<Bill>? bills}) {
    return HomeState(status: status ?? this.status, bills: bills ?? this.bills);
  }
}

class HomeCubit extends Cubit<HomeState> {
  DatabaseRepository databaseRepository;
  StreamSubscription? _subscription;
  HomeCubit(this.databaseRepository) : super(HomeState.initial()) {
    _subscription = databaseRepository.billStream.listen((bills) {
      emit(state.copyWith(status: HomeStatus.loaded, bills: bills));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
