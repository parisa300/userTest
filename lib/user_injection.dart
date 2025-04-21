
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/data/datasource/user_remote_data_source.dart';
import 'features/data/repositories/user_repository_impl.dart';
import 'features/domain/repositories/user_repository.dart';
import 'features/domain/usecases/get_users.dart';
import 'features/domain/usecases/login_usecase.dart';
import 'features/presentation/bloc/user/user_bloc.dart';
import 'features/presentation/bloc/user_list/user_list_bloc.dart';

final sl = GetIt.instance;

void initUserFeature() {


  // Dio client
  sl.registerLazySingleton<Dio>(() => Dio());

  // DataSource
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(sl()));

  // Bloc
  sl.registerLazySingleton<UserListBloc>(() => UserListBloc(sl()));
  // Bloc
  sl.registerFactory(() => UserBloc(sl()));

  // External

}
Future<void> init() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());
  // بقیه‌ی وابستگی‌ها رو هم اینجا تعریف می‌کنی
}
