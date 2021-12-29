
import 'package:home_travling/featuers/fetch_cities/data/model/city_model.dart';

abstract class CitiesRemoteDataSource {
   /// calls cities collection  from the for firestore
  /// Throws a [ServerException] for all error codes.
  Future<List<CityModel>> getCitiesList(String countryId);
}