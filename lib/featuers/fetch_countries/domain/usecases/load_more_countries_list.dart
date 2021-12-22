import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';

class LoadMoreCountriesList implements UseCase<List<CountryEntity>,Params> {
  final CountriesRepositry countriesRepositry;

  LoadMoreCountriesList(this.countriesRepositry);
  @override
  Future<Either<Failure, List<CountryEntity>>> call(parmas) async {
    return await countriesRepositry
        .loadMoreCountriesList(parmas.lastDocumentSnapShot);
  }
}

class Params extends Equatable {
  final DocumentSnapshot lastDocumentSnapShot;

  const Params({required this.lastDocumentSnapShot});
  @override
  // TODO: implement props
  List<Object?> get props => [lastDocumentSnapShot];
}


