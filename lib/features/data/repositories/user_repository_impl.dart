
import '../../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure('Login failed: ${e.toString()}'));
    }
  }
}
