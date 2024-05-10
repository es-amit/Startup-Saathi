part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthRegister extends AuthEvent {
  final String email;
  final String password;
  final String phoneNumber;

  AuthRegister({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin({
    required this.email,
    required this.password,
  });
}

final class AuthCheckRequested extends AuthEvent {}
