
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:new_project/features/presentation/bloc/user_list/user_list_event.dart';
import 'package:new_project/features/presentation/bloc/user_list/user_list_state.dart';

import '../../../data/datasource/user_remote_data_source.dart';


class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final RemoteDataSource remoteDataSource;

  UserListBloc(this.remoteDataSource) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserListState> emit) async {
    emit(UserLoading());
    try {
      final users = await remoteDataSource.getUsers(event.page);
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to load users'));
    }
  }
}
