import 'package:startup_saathi/features/domain/entities/user_entity.dart';

import '../../repository/firebase_repository.dart';

class RegisterUseCase {
  final FirebaseRepository repository;

  RegisterUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.registerUser(userEntity);
  }
}
