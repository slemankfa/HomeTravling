import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/fetch_cities/data/model/city_model.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';

import '../../../cities_list.dart';

void main() async {
  

  final instance = FakeFirebaseFirestore();

  test("should be a subclass from CityEntity", () {
    //assert
    expect(tCityModel, isA<CityEntity>());
  });

  group("From Json", () {
    test("Should return a valid model from the document snapshot map ",
        () async {
      await instance.collection('cities').add({
        'city_image':
            "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
        "country_id": "1",
        "city_id": "1",
        "city_name_ar": "بارما",
        "city_name_en": "Parma"
      });

      final snapshot = await instance.collection('cities').get();
      final firstDocument = snapshot.docs.first;
      // arrange
      final Map<String, dynamic> jsonMap = firstDocument.data();
      // act
      final result = CityModel.fromJson(jsonMap);
      // assert
      expect(result, tCityModel);
    });

    test(
        "should return a valid model when Json country_id and city_id regarded as a int ",
        () async {
      await instance.collection('cities').add({
        'city_image':
            "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
        "country_id": 1,
        "city_id": 1,
        "city_name_ar": "بارما",
        "city_name_en": "Parma"
      });

      final snapshot = await instance.collection('cities').get();
      final firstDocument = snapshot.docs[1];
      // arrange
      final Map<String, dynamic> jsonMap = firstDocument.data();
      // act
      final result = CityModel.fromJson(jsonMap);
      // assert
      expect(result, tCityModel);
    });
  });
}
