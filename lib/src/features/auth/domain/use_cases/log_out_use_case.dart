import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/components/usecase/usecase.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase implements UseCase<void, NoParams, void> {
  final AuthRepository authRepository;

  LogOutUseCase(
    this.authRepository,
  );

  @override
  Future<Either<void, void>> call(NoParams params) async {
    final res = await authRepository.logOut();
    return right(res);
  }
}
