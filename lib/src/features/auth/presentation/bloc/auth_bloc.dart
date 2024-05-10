import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/src/components/usecase/usecase.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/is_logged_in_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/register_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.isLoggedInUseCase,
  }) : super(AuthInitial()) {
    // on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthCheckRequested>(_checkUserLoggedIn);
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogin>(_onAuthLogin);
  }

  void _checkUserLoggedIn(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final res = await isLoggedInUseCase.call(NoParams());
    res.fold(
      (l) => emit(UnAuthenticated()),
      (r) => emit(Authenticated()),
    );
  }

  void _onAuthRegister(
    AuthRegister event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final res = await registerUseCase(RegisterParams(
        email: event.email,
        password: event.password,
        phoneNumber: event.phoneNumber,
      ));
      res.fold(
        (failure) {
          emit(AuthFailure(failure));
        },
        (user) => emit(AuthSuccess(user)),
      );
    } on AuthError catch (e) {
      emit(AuthFailure(e));
    }
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final res = await loginUseCase(LoginParams(
        email: event.email,
        password: event.password,
      ));
      res.fold(
        (failure) {
          emit(AuthFailure(failure));
        },
        (user) => emit(AuthLoginSuccess(user)),
      );
    } on AuthError catch (e) {
      emit(AuthFailure(e));
    }
  }
}
