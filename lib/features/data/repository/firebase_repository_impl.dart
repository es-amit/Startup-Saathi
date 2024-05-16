import 'package:startup_saathi/features/data/datasource/remote_data_source.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<bool> isSignedIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> logInUser(UserEntity user) async =>
      await remoteDataSource.logInUser(user);

  @override
  Future<void> registerUser(UserEntity user) async =>
      await remoteDataSource.registerUser(user);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<String> getCurrentUid() async =>
      await remoteDataSource.getCurrentUid();

  @override
  Future<void> resetPassword(String email) async {
    await remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    return remoteDataSource.getSingleUser(uid);
  }
}
