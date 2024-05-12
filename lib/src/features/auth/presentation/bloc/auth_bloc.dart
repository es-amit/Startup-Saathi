import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/init_dependencies.dart';
import 'package:startup_saathi/src/components/usecase/usecase.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/is_logged_in_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/register_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final LogOutUseCase logOutUseCase;
  final RegisterUseCase registerUseCase;
  AuthBloc(
    this.loginUseCase,
    this.isLoggedInUseCase,
    this.logOutUseCase,
    this.registerUseCase,
  ) : super(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        ) {
    on<AuthEventLogin>(_onAuthLogin);
    on<AuthEventInitialize>(_onAuthEventInitialize);
    on<AuthEventLogOut>(_onAuthEventLogOut);
    on<AuthEventRegister>(_onAuthEventRegister);
    on<AuthEventGoToLogin>(_onAuthEventGoToLogin);
    on<AuthEventGoToRegistration>(_onAuthEventGoToRegistration);
  }

  void _onAuthEventGoToLogin(
    AuthEventGoToLogin event,
    Emitter<AuthState> emit,
  ) {
    emit(
      const AuthStateLoggedOut(
        isLoading: false,
      ),
    );
  }

  void _onAuthEventGoToRegistration(
    AuthEventGoToRegistration event,
    Emitter<AuthState> emit,
  ) {
    emit(
      const AuthStateIsInRegistrationView(
        isLoading: false,
      ),
    );
  }

  void _onAuthEventRegister(
    AuthEventRegister event,
    Emitter<AuthState> emit,
  ) async {
    // start loading
    emit(
      const AuthStateIsInRegistrationView(
        isLoading: true,
      ),
    );
    final email = event.email;
    final password = event.password;
    final phoneNumber = event.phoneNumber;
    try {
      // create the user
      final res = await registerUseCase(
        RegisterParams(
          email: email,
          password: password,
          phoneNumber: phoneNumber,
        ),
      );

      res.fold(
        (error) {
          log(error.toString());
          emit(
            AuthStateIsInRegistrationView(
              isLoading: false,
              authError: error,
            ),
          );
          log('error state');
        },
        (user) {
          // user created successfully
          log('accha');
          emit(
            AuthStateLoggedIn(
              isLoading: false,
              user: user,
            ),
          );
          log('logged in state');
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AuthStateIsInRegistrationView(
          isLoading: false,
          authError: AuthError.from(e),
        ),
      );
    }
  }

  void _onAuthEventLogOut(
    AuthEventLogOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      const AuthStateLoggedOut(
        isLoading: true,
      ),
    );
    final res = await logOutUseCase(NoParams());
    res.fold(
      (l) => emit(const AuthStateLoggedOut(
        isLoading: false,
      )),
      (r) => emit(
        const AuthStateLoggedOut(
          isLoading: false,
        ),
      ),
    );
  }

  void _onAuthEventInitialize(
    AuthEventInitialize event,
    Emitter<AuthState> emit,
  ) async {
    final user = serviceLocator<FirebaseAuth>().currentUser;
    if (user != null) {
      emit(
        AuthStateLoggedIn(
          isLoading: false,
          user: user,
        ),
      );
    } else {
      emit(
        const AuthStateLoggedOut(
          isLoading: false,
        ),
      );
    }
  }

  void _onAuthLogin(
    AuthEventLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      const AuthStateLoggedOut(
        isLoading: true,
      ),
    );

    try {
      final email = event.email;
      final password = event.password;
      final res = await loginUseCase(
        LoginParams(
          email: email,
          password: password,
        ),
      );
      res.fold(
        (error) => emit(
          AuthStateLoggedOut(
            isLoading: false,
            authError: error,
          ),
        ),
        (user) => emit(
          AuthStateLoggedIn(
            isLoading: false,
            user: user,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AuthStateLoggedOut(
          isLoading: false,
          authError: AuthError.from(e),
        ),
      );
    }
  }
}
