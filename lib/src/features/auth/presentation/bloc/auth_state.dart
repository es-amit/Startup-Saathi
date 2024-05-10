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

final class AuthStoredSucess extends AuthState {}

final class AuthStoreFailure extends AuthState {
  final String message;

  const AuthStoreFailure({
    required this.message,
  });
}
