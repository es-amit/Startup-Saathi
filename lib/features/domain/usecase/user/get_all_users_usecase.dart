import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';

class GetAllUsersUseCase {
  final FirebaseRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call(String currentUser) {
    return repository.getAllUsers(currentUser);
  }
}
