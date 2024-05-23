import 'dart:io';

import 'package:startup_saathi/features/data/model/user_model.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';

abstract interface class FirebaseRemoteDataSource {
  // Credentials
  Future<void> logInUser(String email, String password);
  Future<void> registerUser(String email, String password);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);

  // Cloud Storage
  Future<String> uploadImageToStorage(
    File? file,
  );

  Future<void> storeUserInfo(UserModel user);

  // User
  Future<String> getCurrentUid();
  Stream<List<UserEntity>> getSingleUser(String uid);
}
