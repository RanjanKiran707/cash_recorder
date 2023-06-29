import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension DialogExt on Widget {
  Future<T?> showDialogBlocExt<T extends Cubit>({
    required BuildContext context,
    bool barrierDismissible = false,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context1) => BlocProvider.value(
        value: context.read<T>(),
        child: this,
      ),
    );
  }

  Future<T?> showDialogExt<T>({
    required BuildContext context,
    bool barrierDismissible = false,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context1) => this,
    );
  }
}

extension GapBox on int {
  Widget get hBox => SizedBox(height: this.toDouble());
  Widget get wBox => SizedBox(width: this.toDouble());
}
