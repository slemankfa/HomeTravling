import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';

abstract class CountriesRemoteDataSource {
  /// calls countries collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryEntity>> getCountriesList() async {
    // TODO: implement getCountriesList
   return Future.value([]);
  }

  /// calls countries collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryEntity>> loadMoreCountriesList(
      DocumentSnapshot<Object?> lastDocumentSnapshot) {
    // TODO: implement loadMoreCountriesList
    throw UnimplementedError();
  }
}
