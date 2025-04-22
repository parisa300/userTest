
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/features/domain/usecases/create_usecase.dart';
import 'features/data/datasource/firebase_data_source.dart';
import 'features/data/datasource/user_remote_data_source.dart';
import 'features/data/repositories/user_repository_impl.dart';
import 'features/domain/repositories/user_repository.dart';
import 'features/domain/usecases/delete_usecase.dart';
import 'features/domain/usecases/get_users_list_usecase.dart';
import 'features/domain/usecases/login_usecase.dart';
import 'features/domain/usecases/update_usecase.dart';
import 'features/presentation/bloc/user/user_bloc.dart';
import 'features/presentation/bloc/user_list/user_list_bloc.dart';

final sl = GetIt.instance;

void initUserFeature() {


  // Dio client
  sl.registerLazySingleton<Dio>(() => Dio());
  // Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Data source
  sl.registerLazySingleton(() => FirebaseAuthDataSource(sl()));
  // DataSource
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersListUseCase(sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  // Bloc

  sl.registerFactory(() => UserListBloc(
    sl<GetUsersListUseCase>(),
    sl<CreateUserUseCase>(),
    sl<DeleteUserUseCase>(),
    sl<UpdateUserUseCase>(),
  ));
  // Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl()));
}
Future<void> init() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());
  // بقیه‌ی وابستگی‌ها رو هم اینجا تعریف می‌کنی
}
