import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/features/data/datasource/errors/firebase_error_handler.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/usecase/user/log_in_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/register_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/reset_password_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/store_user_info_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  bool isRegistering = false;
  final LogInUserUseCase logInUserUseCase;
  final RegisterUseCase registerUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final StoreUserInfoUseCase storeUserInfoUseCase;

  UserEntity? userEntity;

  CredentialCubit({
    required this.logInUserUseCase,
    required this.registerUseCase,
    required this.resetPasswordUseCase,
    required this.storeUserInfoUseCase,
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
      isRegistering = false;
      await logInUserUseCase.call(
        email,
        password,
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
    required String email,
    required String password,
  }) async {
    isRegistering = true;
    emit(CredentialLoading());
    try {
      await registerUseCase.call(
        email,
        password,
      );
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(const CredentialFailure());
    } catch (e) {
      log(e.toString());
      final error = e as AuthError;
      emit(CredentialFailure(
        errorTitle: error.dialogTitle,
        errorMessage: error.dialogText,
      ));
    }
  }

  Future<void> storeUserDetails({
    required UserEntity user,
  }) async {
    emit(CredentialLoading());
    log(user.toString());
    try {
      await storeUserInfoUseCase.call(
        user,
      );
      emit(CredentialUserInfoStored());
    } catch (e) {
      emit(const CredentialPersonalInfoFailure());
    }
  }
}
