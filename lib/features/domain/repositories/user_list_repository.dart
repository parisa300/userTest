
import '../entities/user_list_entity.dart';

abstract class UserListRepository {
  Future<List<UserListEntity>> getUsers(int page);

  Future<void> createUser(String name, String job);
  Future<void> updateUser(int id, String name, String job);
  Future<void> deleteUser(int id);
}