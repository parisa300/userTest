

import '../../domain/entities/user_list_entity.dart';
import '../../domain/repositories/user_list_repository.dart';
import '../datasource/user_remote_data_source.dart';

class UserListRepositoryImpl implements UserListRepository {
  final RemoteDataSource remoteDataSource;

  UserListRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<UserListEntity>> getUsers(int page) async {
    return await remoteDataSource.getUsers(page);
  }
  @override
  Future<void> createUser(String name, String job) => remoteDataSource.createUser(name, job);

  @override
  Future<void> updateUser(int id, String name, String job) => remoteDataSource.updateUser(id, name, job);

  @override
  Future<void> deleteUser(int id) => remoteDataSource.deleteUser(id);
}