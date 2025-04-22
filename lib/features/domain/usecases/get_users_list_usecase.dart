import '../entities/user_list_entity.dart';
import '../repositories/user_list_repository.dart';

class GetUsersListUseCase {
  final UserListRepository repository;

  GetUsersListUseCase(this.repository);

  Future<List<UserListEntity>> call(int page) {
    return repository.getUsers(page);
  }
}