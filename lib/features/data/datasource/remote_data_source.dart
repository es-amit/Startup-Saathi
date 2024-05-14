import 'dart:io';

import 'package:startup_saathi/features/domain/entities/user_entity.dart';

abstract interface class FirebaseRemoteDataSource {
  // Credentials
  Future<void> logInUser(UserEntity user);
  Future<void> registerUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  // Cloud Storage
  Future<String> uploadImageToStorage(File? file, String childName);

  // User
  Future<String> getCurrentUid();
}
