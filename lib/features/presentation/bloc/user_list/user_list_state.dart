
import 'package:equatable/equatable.dart';

import '../../../data/model/user_list_model.dart';


abstract class UserListState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserListState {}

class UserLoading extends UserListState {}

class UserLoaded extends UserListState {
  final List<UserList> users;

  UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserError extends UserListState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}
