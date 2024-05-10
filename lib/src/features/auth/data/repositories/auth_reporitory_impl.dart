import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';
import 'package:startup_saathi/src/features/auth/data/network/failure.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
  );
  @override
  Future<Either<AuthError, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final user = await authRemoteDataSource.registerWithEmailAndPassword(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(
        authErrorMapping[e.code.toLowerCase().trim()] as AuthError,
      );
    }
  }

  @override
  Future<Either<Failure, void>> storeUserInfo({
    required UserModel userModel,
  }) async {
    try {
      await authRemoteDataSource.storeUserInfo(userModel: userModel);
      return right(null);
    } catch (e) {
      return left(Failure(message: "Can't store data"));
    }
  }
}
