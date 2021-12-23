import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/featuers/fetch_countries/data/datasources/countries_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_countries/data/models/country_model.dart';
import 'package:mocktail/mocktail.dart';

class MockQuerySnapShot extends Mock implements QuerySnapshot {}

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  FakeFirebaseFirestore instance = FakeFirebaseFirestore();
  MockFirestore mockFirestore = MockFirestore();

  CountriesRemoteDataSourceImpl dataSource =
      CountriesRemoteDataSourceImpl(instance);

  await instance.collection('countries').add(
    {
      'country_flag':
          'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
      "country_id": "1",
      "country_name_ar": "إيطاليا",
      "country_name_en": "Italy"
    },
  );
  await instance.collection('countries').add({
    'country_flag':
        'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
    "country_id": "2",
    "country_name_ar": "اليابان",
    "country_name_en": "Japan"
  });

   
  final snapshot = await instance.collection('countries').get();
  final firstDocument = snapshot.docs.first;
  // final firstDocument = snapshot.docs.first;

  List<CountryModel> tCountriesList = const [
    CountryModel(
      countryEnglishName: "Italy",
      countryArabicName: "إيطاليا",
      countryId: "1",
      countryFlag:
          "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
    ),
  ];

  void setUpGetCountries() async {
    QuerySnapshot<Map<String, dynamic>> snapShots =
        await instance.collection('countries').limit(1).get();

    when(() => mockFirestore.collection("countries").limit(1).get())
        .thenAnswer((_) async => snapShots);
  }

  void setUpLoadMoreCountries(DocumentSnapshot documentSnapshot) async {
    QuerySnapshot<Map<String, dynamic>> snapShots = await instance
        .collection('countries')
        .limit(1)
        .startAfterDocument(documentSnapshot)
        .get();

    when(() => mockFirestore
        .collection("countries")
        .limit(1)
        .startAfterDocument(documentSnapshot)
        .get()).thenAnswer((_) async => snapShots);
  }

  ///https://utkarshkore.medium.com/writing-unit-tests-in-flutter-with-firebase-firestore-72f99be85737
  group("getCountriesList", () {
    test("should perform a query to get countries from the firebase endpoint",
        () async {
      // arrange
      // final snapshot = await instance.collection('countries').limit(1).get();
      setUpGetCountries();
      // act
      dataSource.getCountriesList();
      // assert
      // verify(() =>snapShots);
    });

    // -------

    test("Should return countries list when the query done successfully ",
        () async {
      // arrange
      setUpGetCountries();
      // act
      final result = await dataSource.getCountriesList();
      // assert
      expect(result, equals(tCountriesList));
    });

    //-----
  });

  group("LoadMoreCountries", () {
    List<CountryModel> tLoadMoreCountriesList = const [
      CountryModel(
        countryEnglishName: "Japan",
        countryArabicName: "اليابان",
        countryId: "2",
        countryFlag:
            "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
      ),
    ];
    test(
        "should perform a query to load more countries from the firebase endpoint",
        () async {
      // arrange
      // final snapshot = await instance.collection('countries').limit(1).get();
      setUpLoadMoreCountries(firstDocument);
      // act
      dataSource.loadMoreCountriesList(firstDocument);
      // assert
      // verify(() =>snapShots);
    });

    // -------

      test("Should return countries list when the query done successfully ",
        () async {
      // arrange
      QuerySnapshot<Map<String, dynamic>> snapShots = await instance
          .collection('countries')
          .startAfterDocument(firstDocument)
          .limit(2)
          .get();
      
      when(() => mockFirestore
          .collection("countries")
          .startAfterDocument(firstDocument)
          .limit(2)
          .get()).thenAnswer((_) async => snapShots);
      // act
      final result = await dataSource.loadMoreCountriesList(firstDocument);
      // assert
      expect(result, equals(tLoadMoreCountriesList));
    });

    //-----
  });
}
