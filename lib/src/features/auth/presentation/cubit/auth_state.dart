part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
}

@immutable
class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String user;

  const Authenticated({
    required this.user,
  });

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}
