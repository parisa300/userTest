import '../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';


class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, User>> call(String email, String password) {
    return repository.login(email, password);
  }
}