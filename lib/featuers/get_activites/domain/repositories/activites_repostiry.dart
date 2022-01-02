import 'package:dartz/dartz.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';

abstract class ActivitiesRepostiry {
  Future<Either<Failure, List<ActivityEntity>>> getActivitesList(String cityId);
}
