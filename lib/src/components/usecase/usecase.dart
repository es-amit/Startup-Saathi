import 'package:fpdart/fpdart.dart';
import 'package:startup_saathi/src/features/auth/data/network/firebase_error_handler.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<AuthError, SuccessType>> call(Params params);
}

class NoParams {}
