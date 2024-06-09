import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';

class ResetPasswordUseCase {
  final FirebaseRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call(String email) async {
    return await repository.resetPassword(email);
  }
}
