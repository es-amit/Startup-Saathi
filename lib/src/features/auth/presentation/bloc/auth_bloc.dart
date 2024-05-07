import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/register_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  AuthBloc({
    required this.registerUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));

    on<AuthRegister>(_onAuthRegister);
  }

  void _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    final res = await registerUseCase(RegisterParams(
      email: event.email,
      password: event.password,
      phoneNumber: event.phoneNumber,
    ));
    res.fold(
      (l) => emit(AuthFailure(l.dialogTitle, l.dialogText)),
      (r) => emit(AuthSuccess(r)),
    );
  }
}
