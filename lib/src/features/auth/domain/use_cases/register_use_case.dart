import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/components/usecase/usecase.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase(
    this.authRepository,
  );
  @override
  Future<Either<AuthError, UserEntity>> call(RegisterParams params) async {
    return await authRepository.registerWithEmailAndPassword(
      email: params.email,
      password: params.password,
      phoneNumber: params.phoneNumber,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String phoneNumber;

  RegisterParams({
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}
