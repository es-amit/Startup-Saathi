import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/features/data/datasource/errors/firebase_error_handler.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/usecase/user/log_in_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/register_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/reset_password_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final LogInUserUseCase logInUserUseCase;
  final RegisterUseCase registerUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  CredentialCubit({
    required this.logInUserUseCase,
    required this.registerUseCase,
    required this.resetPasswordUseCase,
  }) : super(CredentialInitial());

  Future<void> resetPassword({
    required String email,
  }) async {
    // emit(CredentialLoading());
    try {
      await resetPasswordUseCase.call(email);
      emit(CredentialEmailSent());
    } on SocketException catch (_) {
      emit(const CredentialFailure());
    } catch (e) {
      final error = e as AuthError;
      emit(CredentialFailure(
        errorTitle: error.dialogTitle,
        errorMessage: error.dialogText,
      ));
    }
  }

  Future<void> logInUser({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await logInUserUseCase.call(
        UserEntity(
          email: email,
          password: password,
        ),
      );
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(const CredentialFailure());
    } catch (e) {
      final error = e as AuthError;
      emit(CredentialFailure(
        errorTitle: error.dialogTitle,
        errorMessage: error.dialogText,
      ));
    }
  }

  Future<void> registerUser({
    required UserEntity user,
  }) async {
    emit(CredentialLoading());
    try {
      await registerUseCase.call(
        user,
      );
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(const CredentialFailure());
    } catch (e) {
      final error = e as AuthError;
      emit(CredentialFailure(
        errorTitle: error.dialogTitle,
        errorMessage: error.dialogText,
      ));
    }
  }
}
