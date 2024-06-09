import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:startup_saathi/core/cubit/internet_cubit.dart';
import 'package:startup_saathi/features/data/datasource/remote_data_source.dart';
import 'package:startup_saathi/features/data/datasource/remote_data_source_impl.dart';
import 'package:startup_saathi/features/data/repository/firebase_repository_impl.dart';
import 'package:startup_saathi/features/domain/repository/firebase_repository.dart';
import 'package:startup_saathi/features/domain/usecase/user/get_all_users_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/get_current_uid_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/get_single_user_usercase.dart';
import 'package:startup_saathi/features/domain/usecase/user/is_login_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/log_in_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/register_user_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/reset_password_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/sign_out_usecase.dart';
import 'package:startup_saathi/features/domain/usecase/user/store_user_info_usecase.dart';
import 'package:startup_saathi/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/user/get_all_users/get_all_users_cubit.dart';
import 'package:startup_saathi/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Cubits
  serviceLocator.registerFactory(
    () => AuthCubit(
      signOutUseCase: serviceLocator.call(),
      signInUseCase: serviceLocator.call(),
      getCurrentUidUseCase: serviceLocator.call(),
      internetCubit: serviceLocator.call(),
    ),
  );

  serviceLocator.registerFactory(
    () => InternetCubit(
      internetConnection: serviceLocator.call(),
    ),
  );
  serviceLocator.registerFactory(
    () => CredentialCubit(
      logInUserUseCase: serviceLocator.call(),
      registerUseCase: serviceLocator.call(),
      resetPasswordUseCase: serviceLocator.call(),
      storeUserInfoUseCase: serviceLocator.call(),
    ),
  );
  serviceLocator.registerFactory(
    () => GetSingleUserCubit(
      getSingleUserUseCase: serviceLocator.call(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllUsersCubit(
      getAllUsersUseCase: serviceLocator.call(),
    ),
  );

  // UseCases
  // User

  serviceLocator.registerLazySingleton(
      () => StoreUserInfoUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => SignOutUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => IsSignInUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => GetCurrentUidUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => RegisterUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => LogInUserUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => ResetPasswordUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => GetSingleUserUseCase(repository: serviceLocator.call()));

  serviceLocator.registerLazySingleton(
      () => GetAllUsersUseCase(repository: serviceLocator.call()));

  // Repositories
  serviceLocator.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: serviceLocator.call()));

  // DataSources
  serviceLocator.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firebaseAuth: serviceLocator.call(),
          firebaseFirestore: serviceLocator.call(),
          firebaseStorage: serviceLocator.call()));

  // External
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final connectionChecker = InternetConnection.createInstance();

  serviceLocator.registerLazySingleton(() => firebaseFirestore);
  serviceLocator.registerLazySingleton(() => firebaseAuth);
  serviceLocator.registerLazySingleton(() => firebaseStorage);
  serviceLocator.registerLazySingleton(() => connectionChecker);
}
