part of 'get_all_users_cubit.dart';

abstract class GetAllUsersState extends Equatable {
  const GetAllUsersState();
}

class GetAllUserLoadingState extends GetAllUsersState {
  @override
  List<Object> get props => [];
}

class GetAllUserSuccessState extends GetAllUsersState {
  final List<UserEntity> users;

  const GetAllUserSuccessState({
    required this.users,
  });

  @override
  List<Object> get props => [users];
}

class GetAllUserFailureState extends GetAllUsersState {
  final String errorTitle;
  final String errorMessage;

  const GetAllUserFailureState({
    required this.errorTitle,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        errorTitle,
        errorMessage,
      ];
}
