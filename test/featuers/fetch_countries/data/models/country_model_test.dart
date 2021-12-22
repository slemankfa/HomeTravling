import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/fetch_countries/data/models/country_model.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';

void main() async {
  CountryModel tCountryModel = const CountryModel(
      countryArabicName: "إيطاليا",
      countryEnglishName: "Italy",
      countryFlag:
          "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
      countryId: "1");

  final instance = FakeFirebaseFirestore();

  test("should be a subclass from Country Entity", () {
    // assert
    expect(tCountryModel, isA<CountryEntity>());
  });

  group("From Json", () {
    test("should return a valid model from the document snapshot map ",
        () async {
      await instance.collection('countries').add({
        'country_flag':
            'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
        "country_id": "1",
        "country_name_ar": "إيطاليا",
        "country_name_en": "Italy"
      });
      final snapshot = await instance.collection('countries').get();
      final firstDocument = snapshot.docs.first;
      // arrange
      final Map<String, dynamic> jsonMap = firstDocument.data();
      // act
      final result = CountryModel.fromJson(jsonMap);
      // assert
      expect(result, tCountryModel);
    });

    test(
        " should return a valid model when the JSON country_id is regarded as a int ",
        () async {
      await instance.collection('countries').add({
        'country_flag':
            'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
        "country_id": 1,
        "country_name_ar": "إيطاليا",
        "country_name_en": "Italy"
      });
      final snapshot = await instance.collection('countries').get();
      final firstDocument = snapshot.docs.first;
      // arrange
      final Map<String, dynamic> jsonMap = firstDocument.data();
      // act
      final result = CountryModel.fromJson(jsonMap);
      // assert
      expect(result, tCountryModel);
    });
  });
}
