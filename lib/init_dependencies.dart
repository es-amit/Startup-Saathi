import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:startup_saathi/src/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:startup_saathi/src/features/auth/data/repositories/auth_reporitory_impl.dart';
import 'package:startup_saathi/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:startup_saathi/src/features/auth/domain/use_cases/register_use_case.dart';
import 'package:startup_saathi/src/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;

  serviceLocator.registerLazySingleton(() => firebaseAuth);
  serviceLocator.registerLazySingleton(() => firebaseFireStore);
}

void _initAuth() {
  serviceLocator
    // ..registerLazySingleton(
    //   () => InternetConnectionChecker(),
    // )
    // ..registerFactory(
    //   () => InternetCubit(
    //     connectionChecker: serviceLocator(),
    //   ),
    // )
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => RegisterUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => LoginUseCase(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        registerUseCase: serviceLocator(),
        loginUseCase: serviceLocator(),
      ),
    );
}
