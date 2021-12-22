import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/load_more_countries_list.dart';
import 'package:mocktail/mocktail.dart';

import 'get_countries_list_test.dart';

class MockCountryRepostiry extends Mock implements CountriesRepositry {}

void main() async {
  MockCountryRepostiry mockCountriesRepositry = MockCountryRepostiry();
  LoadMoreCountriesList useCase = LoadMoreCountriesList(mockCountriesRepositry);
  final instance = FakeFirebaseFirestore();

  List<CountryEntity> tCountriesList = const [
    CountryEntity(
      countryEnglishName: "Italy",
      countryArabicName: "ايطاليا",
      countryId: "1",
      countryFlag:
          "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
    ),
   
  ];

  test("Should load more countries from the repositry", () async {
    await instance.collection('countries').add({
      'country_flag': 'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
      "country_id": "1", 
      "country_name_ar": "إيطاليا", 
      "country_name_en" : "Italy"
    });
    final snapshot = await instance.collection('countries').get();
    final firstDocument = snapshot.docs.first;
    // (firstDocument.data());
    //arrange
    when(() => mockCountriesRepositry.loadMoreCountriesList(firstDocument))
        .thenAnswer((_) async => Right(tCountriesList));
    // act
    final result = await useCase(Params(lastDocumentSnapShot: firstDocument));
    // assert
    expect(result, Right(tCountriesList));
    verify(() => mockCountriesRepositry.loadMoreCountriesList(firstDocument));
  });
}
