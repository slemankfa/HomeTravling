import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/login/data/datasource/login_remote_data_source.dart';
import 'package:home_travling/featuers/login/data/models/user_model.dart';
import 'package:home_travling/featuers/login/domain/entities/user_entity.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/featuers/login/domain/repositories/login_repositry.dart';

typedef Future<UserModel> _SignInWithEmailOrGoogle();

class LoginRepositryImpl implements LoginRepostiry {
  final NetworkInfo networkInfo;
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositryImpl({
    required this.networkInfo,
    required this.loginRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
      String email, String password) async {
    // TODO: implement signInWithEmail
    return _signIn(() {
      return loginRemoteDataSource.signInWithEmail(email, password);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    // TODO: implement signInWithGoogle

    return _signIn(() {
      return loginRemoteDataSource.signInWithGoogle();
    });
  }

  Future<Either<Failure, UserEntity>> _signIn(
      _SignInWithEmailOrGoogle signInWithEmailOrGoogle) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteloginSource = await signInWithEmailOrGoogle();
        return Right(remoteloginSource);
      } catch (e) {
        // will improve error handling in the future and add Server exp and try to return an error message
        return left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
