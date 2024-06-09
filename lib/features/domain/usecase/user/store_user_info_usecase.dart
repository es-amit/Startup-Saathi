import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';

class StoreUserInfoUseCase {
  final FirebaseRepository repository;

  StoreUserInfoUseCase({
    required this.repository,
  });

  Future<void> call(UserEntity userEntity) {
    return repository.storeUserInfo(userEntity);
  }
}
