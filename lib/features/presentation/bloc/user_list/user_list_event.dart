
import 'package:equatable/equatable.dart';


abstract class UserListEvent {}

class FetchUsersListEvent extends UserListEvent {
  final int page;
  FetchUsersListEvent(this.page);
}
class CreateUserEvent extends UserListEvent {
  final String name;
  final String job;
  CreateUserEvent(this.name, this.job);
}

class UpdateUserEvent extends UserListEvent {
  final int id;
  final String name;
  final String job;
  UpdateUserEvent(this.id, this.name, this.job);
}

class DeleteUserEvent extends UserListEvent {
  final int id;
  DeleteUserEvent(this.id);
}