import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final InternetConnection internetConnection;
  StreamSubscription? internetSubscription;
  InternetCubit({
    required this.internetConnection,
  }) : super(const InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription monitorInternetConnection() {
    return internetSubscription =
        internetConnection.onStatusChange.listen((internetStatus) {
      switch (internetStatus) {
        case InternetStatus.connected:
          emit(const InternetConnected());
        case InternetStatus.disconnected:
          emit(const InternetDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    internetSubscription?.cancel();
    return super.close();
  }
}
