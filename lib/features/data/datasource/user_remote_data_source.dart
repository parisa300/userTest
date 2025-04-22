import 'package:dio/dio.dart';
import 'package:new_project/features/data/model/user_list_model.dart';
import '../model/user_model.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource(this.dio);

  Future<UserModel> login(String email, String password) async {
    final response = await dio.post(
      'https://reqres.in/api/login',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {

      return UserModel(token: response.data['token']);
    } else {
      throw Exception('Login failed');
    }
  }

  Future<List<UserListModel>> getUsers(int page) async {
    final response = await dio.get('https://reqres.in/api/users', queryParameters: {'page': page});

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      return data.map((userJson) => UserListModel.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(String name, String job) async {
    await dio.post('https://reqres.in/api/users', data: {'name': name, 'job': job});
  }

  Future<void> updateUser(int id, String name, String job) async {
    await dio.put('https://reqres.in/api/users/$id', data: {'name': name, 'job': job});
  }

  Future<void> deleteUser(int id) async {
    await dio.delete('https://reqres.in/api/users/$id');
  }
}
