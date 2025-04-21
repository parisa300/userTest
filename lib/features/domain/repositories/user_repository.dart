import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(String email, String password);
}