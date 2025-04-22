
import '../repositories/user_list_repository.dart';

class DeleteUserUseCase {
  final UserListRepository repository;
  DeleteUserUseCase(this.repository);

  Future<void> call(int id) => repository.deleteUser(id);
}