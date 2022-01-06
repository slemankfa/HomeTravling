import 'package:dartz/dartz.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/featuers/login/domain/entities/user_entity.dart';

abstract class LoginRepostiry {
  Future<Either<Failure, UserEntity>> signInWithEmail(
      String email, String password);
  Future<Either<Failure, UserEntity>> signInWithGoogle();
}
