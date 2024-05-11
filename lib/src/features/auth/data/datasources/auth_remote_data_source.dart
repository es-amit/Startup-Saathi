import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<void> storeUserDetails({
    required UserModel user,
  });

  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User?> isLoggedIn();

  Future<void> logOut();
}
