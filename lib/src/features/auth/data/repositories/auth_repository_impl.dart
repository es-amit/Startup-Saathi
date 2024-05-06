import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<void> forgotPassword(String email) async {
    await remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<String> getCurrentUId() async {
    return await remoteDataSource.getCurrentUId();
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return await remoteDataSource.isUserLoggedIn();
  }

  @override
  Future<void> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await remoteDataSource.logInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logOut() async {
    await remoteDataSource.logOut();
  }

  @override
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
    String phoneNumber,
  ) async {
    await remoteDataSource.registerWithEmailAndPassword(
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<void> saveUserDetails(
    String firstName,
    String lastName,
    String city,
    String college,
  ) async {
    await remoteDataSource.saveUserDetails(
      firstName: firstName,
      lastName: lastName,
      city: city,
      college: college,
    );
  }
}
