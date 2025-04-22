
import '../repositories/user_list_repository.dart';

class UpdateUserUseCase {
  final UserListRepository repository;
  UpdateUserUseCase(this.repository);

  Future<void> call(int id, String name, String job) => repository.updateUser(id, name, job);
}