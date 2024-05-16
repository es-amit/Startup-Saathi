import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';

class StoreUserWithImage {
  final FirebaseRepository repository;

  StoreUserWithImage({
    required this.repository,
  });

  Future<void> call(UserEntity userEntity) {
    return repository.createUserWithImage(userEntity);
  }
}
