import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/login/domain/entities/user_entity.dart';
import 'package:home_travling/featuers/login/domain/repositories/login_repositry.dart';

class SignInWithGoogle implements UseCase<UserEntity, NoParams> {
  final LoginRepostiry loginRepostiry;

  SignInWithGoogle(this.loginRepostiry);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams parmas) {
    // TODO: implement call
    return loginRepostiry.signInWithGoogle();
  }
}
