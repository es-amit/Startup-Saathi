import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/core/cubit/internet_cubit.dart';
import 'package:startup_saathi/features/domain/usecase/user/get_current_uid_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/is_login_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final InternetCubit internetCubit;
  StreamSubscription? internetStreamSubscription;
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase signInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit({
    required this.signOutUseCase,
    required this.signInUseCase,
    required this.getCurrentUidUseCase,
    required this.internetCubit,
  }) : super(AuthInitial()) {
    internetStreamSubscription = internetCubit.stream.listen((internetStatus) {
      if (internetStatus is InternetLoading) {
        emit(AuthLoading());
      } else if (internetStatus is InternetConnected) {
        appStarted();
      } else {
        emit(NoInternet());
      }
    });
  }

  Future<void> appStarted() async {
    try {
      bool isSignIn = await signInUseCase.call();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  @override
  Future<void> close() {
    internetStreamSubscription?.cancel();
    return super.close();
  }
}
