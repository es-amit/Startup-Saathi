part of 'internet_cubit.dart';

abstract class InternetState {
  const InternetState();
}

class InternetLoading extends InternetState {
  const InternetLoading();
}

class InternetConnected extends InternetState {
  const InternetConnected();
}

class InternetDisconnected extends InternetState {
  const InternetDisconnected();
}
