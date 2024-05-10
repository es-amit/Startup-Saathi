import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/components/usecase/usecase.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUseCase implements UseCase<User?, NoParams, void> {
  final AuthRepository authRepository;

  IsLoggedInUseCase(
    this.authRepository,
  );

  @override
  Future<Either<void, User?>> call(NoParams params) async {
    final res = await authRepository.isLoggedIn();
    if (res == null) {
      return left(null);
    }
    return right(res);
  }
}
