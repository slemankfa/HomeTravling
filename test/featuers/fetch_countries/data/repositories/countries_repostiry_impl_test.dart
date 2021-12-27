import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/fetch_countries/data/datasources/countries_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_countries/data/models/country_model.dart';
import 'package:home_travling/featuers/fetch_countries/data/repositories/countries_repostiry_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CountriesRemoteDataSource {}

class MockNetworkinfo extends Mock implements NetworkInfo {}

void main() async {
  MockRemoteDataSource mockRemoteDataSource = MockRemoteDataSource();
  MockNetworkinfo mockNetworkinfo = MockNetworkinfo();
  final instance = FakeFirebaseFirestore();
  CountryRepostiryImpl repostiry = CountryRepostiryImpl(
    remoteDataSource: mockRemoteDataSource,
    networkInfo: mockNetworkinfo,
  );

  await instance.collection('countries').add({
    'country_flag':
        'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
    "country_id": "1",
    "country_name_ar": "إيطاليا",
    "country_name_en": "Italy"
  });
  final snapshot = await instance.collection('countries').get();
  final firstDocument = snapshot.docs.first;

  void runTestOnline(Function body) {
    group('device is online', () {
      setUpAll(() {
        when(() => mockNetworkinfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUpAll(() {
        when(() => mockNetworkinfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("Get Countries List", () {
    List<CountryModel> tCountriesList = const [
      CountryModel(
        countryEnglishName: "Italy",
        countryArabicName: "ايطاليا",
        countryId: "1",
        countryFlag:
            "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
      ),
    ];

    runTestOnline(() {
      test("should check if the device is online", () async {
        // arrange
        when(() => mockRemoteDataSource.getCountriesList())
            .thenAnswer((_) async => tCountriesList);
        // act
        await repostiry.getCountriesList();
        // assert
        verify(() => mockNetworkinfo.isConnected);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange

        when(() => mockRemoteDataSource.getCountriesList())
            .thenAnswer((_) async => tCountriesList);
        // act
        final result = await repostiry.getCountriesList();

        //assert
        verify(() => mockRemoteDataSource.getCountriesList());
        expect(result, equals(Right(tCountriesList)));
      });

      // ------

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getCountriesList())
            .thenThrow(ServerException());
        // act
        final result = await repostiry.getCountriesList();
        // assert
        verify(() => mockRemoteDataSource.getCountriesList());
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    // group("when the device is online", ());

    runTestOffline(() {
      test("should return error message there is no connection", () async {
        // arrange
        when(() => mockRemoteDataSource.getCountriesList())
            .thenThrow(ServerException());
        // act
        final result = await repostiry.getCountriesList();
        // assert
        verify(() => mockNetworkinfo.isConnected);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });

}
