import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List proprites = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props =>  [];
}
