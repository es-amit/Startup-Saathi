// import 'dart:developer';

// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/register_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/store_info_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final StoreInfoUseCase storeInfoUseCase;
  AuthBloc({
    required this.registerUseCase,
    required this.storeInfoUseCase,
  }) : super(AuthInitial()) {
    // on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthRegister>(_onAuthRegister);

    on<AuthStoreInfo>(_onAuthStore);
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
          log(failure.toString());
          emit(AuthFailure(failure));
        },
        (user) => emit(AuthSuccess(user)),
      );
    } on AuthError catch (e) {
      emit(AuthFailure(e));
    }
  }

  void _onAuthStore(
    AuthStoreInfo event,
    Emitter<AuthState> state,
  ) async {
    try {
      emit(AuthLoading());
      final res = await storeInfoUseCase.call(
        event.userModel,
      );
      res.fold(
        (l) => emit(const AuthStoreFailure(message: "Store fail")),
        (r) => emit(AuthStoredSucess()),
      );
    } catch (e) {
      emit(AuthStoreFailure(message: e.toString()));
    }
  }
}
