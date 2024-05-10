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

final class AuthStoreInfo extends AuthEvent {
  final UserModel userModel;

  AuthStoreInfo({
    required this.userModel,
  });
}
