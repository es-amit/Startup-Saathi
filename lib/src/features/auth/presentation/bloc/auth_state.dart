part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final AuthError error;
  const AuthFailure(
    this.error,
  );
}

final class AuthLoginSuccess extends AuthState {
  final User user;
  const AuthLoginSuccess(this.user);
}

final class Authenticated extends AuthState {}

final class UnAuthenticated extends AuthState {}

final class LogOutSuccessState extends AuthState {}

final class LogOutFailureSate extends AuthState {}
