import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/fetch_cities/domain/repositories/cities_repostiry.dart';

class GetCistiesList implements UseCase<List<CityEntity>, Params> {
  final CitiesRepostiry repostiry;

  GetCistiesList(this.repostiry);
  @override
  Future<Either<Failure, List<CityEntity>>> call(parmas) async {
    // TODO: implement call
    return await repostiry.getCitiesList(parmas.countryId);
  }
}

class Params extends Equatable {
  final String countryId;

  const Params({required this.countryId});

  @override
  // TODO: implement props
  List<Object?> get props => [countryId];
}

