
import '../repositories/user_list_repository.dart';

class CreateUserUseCase {
  final UserListRepository repository;
  CreateUserUseCase(this.repository);

  Future<void> call(String name, String job) => repository.createUser(name, job);
}