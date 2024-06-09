import '../../repository/firebase_repository.dart';

class RegisterUseCase {
  final FirebaseRepository repository;

  RegisterUseCase({required this.repository});

  Future<void> call(String email, String password) {
    return repository.registerUser(email, password);
  }
}
