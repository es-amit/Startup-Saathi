import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_saathi/features/domain/entities/user_entity.dart';
import 'package:startup_saathi/features/domain/usecase/user/get_all_users_usecase.dart';
part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  GetAllUsersCubit({
    required this.getAllUsersUseCase,
  }) : super(GetAllUserLoadingState());

  void getAllUsers(String currentUser) {
    try {
      emit(GetAllUserLoadingState());
      getAllUsersUseCase.call(currentUser).listen((users) {
        emit(GetAllUserSuccessState(users: users));
      });
    } catch (e) {
      emit(
        GetAllUserFailureState(
          errorTitle: "Error Occured!",
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
