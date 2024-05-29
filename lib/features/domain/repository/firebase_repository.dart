import 'package:startup_saathi/features/domain/entities/user_entity.dart';

abstract interface class FirebaseRepository {
  // Credential Features
  Future<void> logInUser(String email, String password);
  Future<void> registerUser(String email, String password);
  Future<bool> isSignedIn();
  Future<void> signOut();
  Future<void> resetPassword(String email);

  // store into firestore
  Future<void> storeUserInfo(UserEntity user);

  // user
  Future<String> getCurrentUid();
  Future<UserEntity> getSingleUser(String uid);

  // get all users
  Stream<List<UserEntity>> getAllUsers(String currentUser);
}
