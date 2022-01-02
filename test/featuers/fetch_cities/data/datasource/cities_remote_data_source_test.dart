import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/fetch_cities/data/datasource/cities_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_cities/data/model/city_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../cities_list.dart';

class MockQuerySnapShot extends Mock implements QuerySnapshot {}

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  FakeFirebaseFirestore instance = FakeFirebaseFirestore();
  MockFirestore mockFirestore = MockFirestore();

  CitiesRemoteDataSourceImpl dataSource = CitiesRemoteDataSourceImpl(instance);

  const tCountryId = "1"; 

  List<CityModel> tCitiesList = [
    CityModel( 
        cityArabicName: "بارما",
        cityId: "1",
        countryId: "1",
        cityImage:
            "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
        cityEnglishName: 'Parma')
  ];

  await instance.collection('cities').add({
    'city_image':
        "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
    "country_id": "1",
    "city_id": "1",
    "city_name_ar": "بارما",
    "city_name_en": "Parma"
  });

  void setupGetCities() async {
    QuerySnapshot<Map<String, dynamic>> snapshots = await instance
        .collection("cities")
        .where("country_id", isEqualTo: tCountryId)
        .get();

    when(() => mockFirestore
        .collection("cities")
        .where("country_id", isEqualTo: tCountryId)
        .get()).thenAnswer((_) async => snapshots);
  }

  group("GetCitiesList", () {
    test("should perform a query to get cities from the firestore", () async {
      // arrange
      setupGetCities();
      // act
      dataSource.getCitiesList(tCountryId);
    });

    test("should return cities list when the query done successfully",
        () async {
          // arange 
          setupGetCities();
          // act
          final result = await dataSource.getCitiesList(tCountryId); 
          // assert 
          expect(result, equals(tCitiesList));
        });
  });
}
