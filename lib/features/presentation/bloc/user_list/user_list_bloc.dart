
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/features/domain/usecases/delete_usecase.dart';
import 'package:new_project/features/domain/usecases/update_usecase.dart';
import 'package:new_project/features/presentation/bloc/user_list/user_list_event.dart';
import 'package:new_project/features/presentation/bloc/user_list/user_list_state.dart';
import '../../../domain/usecases/create_usecase.dart';
import '../../../domain/usecases/get_users_list_usecase.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsersListUseCase getUsersListUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserListBloc(this.getUsersListUseCase,
      this.createUserUseCase,
      this.deleteUserUseCase,
      this.updateUserUseCase) : super(UserListInitial()) {
    on<FetchUsersListEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        final users = await getUsersListUseCase(event.page);
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserListError('Failed to load users'));
      }
    });

    on<CreateUserEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        await createUserUseCase(event.name, event.job);
        emit(UserCreateSuccess());

        final users = await getUsersListUseCase(1);
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserListError('Failed to create user'));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        await updateUserUseCase(event.id, event.name, event.job);
        emit(UserUpdateSuccess());

        final users = await getUsersListUseCase(1);
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserListError('Failed to update user'));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(UserListLoading());
      try {
        await deleteUserUseCase(event.id);
        emit(UserDeleteSuccess());

        final users = await getUsersListUseCase(1);
        emit(UserListLoaded(users));
      } catch (e) {
        emit(UserListError('Failed to delete user'));
      }
    });
  }
}
