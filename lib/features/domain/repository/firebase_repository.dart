import 'package:startup_saathi/features/domain/entities/user_entity.dart';

abstract interface class FirebaseRepository {
  // Credential Features
  Future<void> logInUser(UserEntity user);
  Future<void> registerUser(UserEntity user);
  Future<bool> isSignedIn();
  Future<void> signOut();
  Future<void> resetPassword(String email);

  // user
  Future<String> getCurrentUid();
}
