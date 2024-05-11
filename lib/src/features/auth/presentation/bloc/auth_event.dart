part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

@immutable
class AuthEventInitialize implements AuthEvent {
  const AuthEventInitialize();
}

class AuthEventLogOut implements AuthEvent {
  const AuthEventLogOut();
}

@immutable
class AuthEventLogin implements AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin({
    required this.email,
    required this.password,
  });
}

@immutable
class AuthEventRegister implements AuthEvent {
  final String email;
  final String password;
  final String phoneNumber;

  const AuthEventRegister({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}
