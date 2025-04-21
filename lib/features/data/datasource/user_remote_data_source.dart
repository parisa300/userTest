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
      // فرض کن فقط توکن می‌گیریم
      return UserModel(token: response.data['token']);
    } else {
      throw Exception('Login failed');
    }
  }

  Future<List<UserList>> getUsers(int page) async {
    final response = await dio.get('https://reqres.in/api/users', queryParameters: {'page': page});

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['data'];
      return data.map((userJson) => UserList.fromJson(userJson)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
