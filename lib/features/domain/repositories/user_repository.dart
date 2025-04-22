// import 'package:dartz/dartz.dart';
//
// import '../../../core/error/failure.dart';
// import '../entities/user.dart';
//
// abstract class UserRepository {
//   Future<Either<Failure, User>> login(String email, String password);
// }

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserLogin>> login(String email, String password);
  Future<Either<Failure, void>> register(String email, String password);
}