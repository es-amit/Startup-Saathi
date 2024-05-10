import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Params, ErrorType> {
  Future<Either<ErrorType, SuccessType>> call(Params params);
}

class NoParams {}
