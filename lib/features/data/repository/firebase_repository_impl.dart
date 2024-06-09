import 'package:startup_saathi/features/data/datasource/remote_data_source.dart';
import 'package:startup_saathi/features/data/model/user_model.dart';
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
  Future<void> logInUser(String email, String password) async =>
      await remoteDataSource.logInUser(email, password);

  @override
  Future<void> registerUser(String email, String password) async =>
      await remoteDataSource.registerUser(email, password);

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
  Future<UserEntity> getSingleUser(String uid) {
    return remoteDataSource.getSingleUser(uid);
  }

  @override
  Future<void> storeUserInfo(UserEntity user) async {
    final userModel = const UserModel().toModel(user);
    return await remoteDataSource.storeUserInfo(userModel);
  }

  @override
  Stream<List<UserEntity>> getAllUsers(String currentUser) {
    return remoteDataSource.getAllUsers(currentUser);
  }
}
