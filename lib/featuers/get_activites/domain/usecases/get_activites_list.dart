import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';
import 'package:home_travling/featuers/get_activites/domain/repositories/activites_repostiry.dart';

class GetActivitesList implements UseCase<List<ActivityEntity>, Params> {
  final ActivitiesRepostiry repostiry;

  GetActivitesList(this.repostiry);
  @override
  Future<Either<Failure, List<ActivityEntity>>> call(Params parmas) {
    // TODO: implement call
    return repostiry.getActivitesList(parmas.cityId);
  }
}

class Params extends Equatable {
  final String cityId;

  Params({required this.cityId});

  @override
  // TODO: implement props
  List<Object?> get props => [cityId];
}
