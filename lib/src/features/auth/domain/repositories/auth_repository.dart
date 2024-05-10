import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';
import 'package:startup_saathi/src/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<AuthError, UserEntity>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<Either<AuthError, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User?> isLoggedIn();
}
