
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';

abstract class UseCase<Type, Parmas> {
  Future<Either<Failure, Type>> call(Parmas parmas) ;
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];

}