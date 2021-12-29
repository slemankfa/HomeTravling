import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_travling/featuers/fetch_cities/data/model/city_model.dart';

abstract class CitiesRemoteDataSource {
  /// calls cities collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CityModel>> getCitiesList(String countryId);
}

class CitiesRemoteDataSourceImpl implements CitiesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  CitiesRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<List<CityModel>> getCitiesList(String countryId) async {
    // TODO: implement getCitiesList
    List<CityModel> cities = [];
    final loadedCities = await firebaseFirestore
        .collection("cities")
        .where("country_id", isEqualTo: countryId)
        .get();
    for (var item in loadedCities.docs) {
      cities.add(CityModel.fromJson(item.data()));
    }
    return cities;
  }
}
