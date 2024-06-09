import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';

class LogInUserUseCase {
  final FirebaseRepository repository;

  LogInUserUseCase({required this.repository});

  Future<void> call(String email, String password) {
    return repository.logInUser(email, password);
  }
}
