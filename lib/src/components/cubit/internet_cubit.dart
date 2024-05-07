import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:startup_saathi/src/components/cubit/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final InternetConnectionChecker connectionChecker;
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  InternetCubit({
    required this.connectionChecker,
  }) : super(InternetDisconnected());

  StreamSubscription<InternetConnectionStatus> get connectionSubscription =>
      _connectionSubscription;

  void monitorInternetConnection() {
    _connectionSubscription = connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(InternetConnected());
      } else {
        emit(InternetDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _connectionSubscription.cancel();
    return super.close();
  }
}
