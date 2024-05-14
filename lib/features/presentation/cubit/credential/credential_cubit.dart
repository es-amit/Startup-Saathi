import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/usecase/user/log_in_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/register_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final LogInUserUseCase logInUserUseCase;
  final RegisterUseCase registerUseCase;

  CredentialCubit({
    required this.logInUserUseCase,
    required this.registerUseCase,
  }) : super(CredentialInitial());

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
    } catch (error) {
      emit(const CredentialFailure(
        errorTitle: 'Error hai bhai',
        errorMessage: 'bhot khtra hai bhai',
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
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
