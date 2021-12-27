import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/featuers/fetch_countries/data/models/country_model.dart';


abstract class CountriesRemoteDataSource {
  /// calls countries collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CountryModel>> getCountriesList();
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  CountriesRemoteDataSourceImpl(this.firebaseFirestore);
  @override
  Future<List<CountryModel>> getCountriesList() async {
    List<CountryModel> countries = [];
    final loadedCountries =
        await firebaseFirestore.collection("countries").get();
    for (var item in loadedCountries.docs) {
      countries.add(CountryModel.fromJson(item.data()));
    }
    return countries;
  }
}
