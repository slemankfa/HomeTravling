import 'package:dartz/dartz.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';

abstract class CitiesRepostiry {
  Future<Either<Failure, List<CityEntity>>> getCitiesList(String countryId);
}
