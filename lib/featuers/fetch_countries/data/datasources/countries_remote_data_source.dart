import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/featuers/fetch_countries/data/models/country_model.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';

typedef Future<List<CountryEntity>> _LoadCountriesOrLoadMoreList();

abstract class CountriesRemoteDataSource {
  /// calls countries collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryModel>> getCountriesList();

  /// calls countries collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryModel>> loadMoreCountriesList(
      DocumentSnapshot<Object?> lastDocumentSnapshot);
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  CountriesRemoteDataSourceImpl(this.firebaseFirestore);
  @override
  Future<List<CountryModel>> getCountriesList() async {
    List<CountryModel> countries = [];
    final loadedCountries =
        await firebaseFirestore.collection("countries").limit(1).get();
    for (var item in loadedCountries.docs) {
      countries.add(CountryModel.fromJson(item.data()));
    }
    return countries;
  }

  @override
  Future<List<CountryModel>> loadMoreCountriesList(
      DocumentSnapshot lastDocumentSnapshot) async {
    List<CountryModel> countries = [];

    final loadedCountries = await firebaseFirestore
        .collection("countries")
        .startAfterDocument(lastDocumentSnapshot)
        .limit(1)
        .get();

    for (var item in loadedCountries.docs) {
      countries.add(CountryModel.fromJson(item.data()));
    }
    return countries;
  }
}
