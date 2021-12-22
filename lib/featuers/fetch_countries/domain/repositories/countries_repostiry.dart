
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
abstract class CountriesRepositry {
  Future <Either<Failure , List<CountryEntity>>> getCountriesList();
  Future <Either<Failure , List<CountryEntity>>> loadMoreCountriesList(DocumentSnapshot lastDocumentSnapshot);
}