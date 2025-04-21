
import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUsers extends UserListEvent {
  final int page;

  LoadUsers(this.page);
}
