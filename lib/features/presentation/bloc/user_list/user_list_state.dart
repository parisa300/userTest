
import 'package:equatable/equatable.dart';

import '../../../data/model/user_list_model.dart';
import '../../../domain/entities/user_list_entity.dart';


abstract class UserListState {}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserListEntity> users;
  UserListLoaded(this.users);
}

class UserListError extends UserListState {
  final String message;
  UserListError(this.message);
}
class UserCreateSuccess extends UserListState {}

class UserUpdateSuccess extends UserListState {}

class UserDeleteSuccess extends UserListState {}