import 'dart:io';

import 'package:startup_saathi/features/data/model/user_model.dart';

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
  Future<UserModel> getSingleUser(String uid);
  Stream<List<UserModel>> getAllUsers(String currentUser);
}
