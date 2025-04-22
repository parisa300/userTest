
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) {
    return repository.register(email, password);
  }
}