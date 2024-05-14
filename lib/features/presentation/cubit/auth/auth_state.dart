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

@immutable
class Authenticated extends AuthState {
  final String uid;

  const Authenticated({required this.uid});
  @override
  List<Object> get props => [uid];
}

@immutable
class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
