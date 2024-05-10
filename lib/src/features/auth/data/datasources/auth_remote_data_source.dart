import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<void> storeUserInfo({
    required UserModel userModel,
  });
}
