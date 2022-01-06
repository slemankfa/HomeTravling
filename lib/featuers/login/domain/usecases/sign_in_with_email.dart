import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/login/domain/entities/user_entity.dart';
import 'package:home_travling/featuers/login/domain/repositories/login_repositry.dart';

class SignInWithEmail implements UseCase<UserEntity, SignInWithEmailParams> {
  final LoginRepostiry repostiry;

  SignInWithEmail(this.repostiry);
  @override
  Future<Either<Failure, UserEntity>> call(SignInWithEmailParams parmas) {
    // TODO: implement call
    return repostiry.signInWithEmail(parmas.email, parmas.password);
  }
}

class SignInWithEmailParams extends Equatable {
  final String email, password;

  SignInWithEmailParams({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
