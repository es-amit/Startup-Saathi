import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/components/usecase/usecase.dart';
import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';
import 'package:startup_saathi/src/features/auth/data/network/failure.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';

class StoreInfoUseCase implements UseCase<void, UserModel, Failure> {
  final AuthRepository authRepository;

  StoreInfoUseCase(
    this.authRepository,
  );
  @override
  Future<Either<Failure, void>> call(UserModel params) async {
    return authRepository.storeUserInfo(
      userModel: params,
    );
  }
}
