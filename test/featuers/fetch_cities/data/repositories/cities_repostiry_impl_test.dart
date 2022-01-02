import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/fetch_cities/data/datasource/cities_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_cities/data/model/city_model.dart';
import 'package:home_travling/featuers/fetch_cities/data/repositories/cities_repostiry_impl.dart';
import 'package:mocktail/mocktail.dart';


class MockNetworkinfo extends Mock implements NetworkInfo {}

class MockCitiesRemoteDataSource extends Mock
    implements CitiesRemoteDataSource {}

void main() {
  MockNetworkinfo mockNetworkinfo = MockNetworkinfo();
  MockCitiesRemoteDataSource mockRemoteDataSource =
      MockCitiesRemoteDataSource();

  final instance = FakeFirebaseFirestore();
  const tCountryId = "1";

  CitiesRepostiryImpl repostiry = CitiesRepostiryImpl(
    remoteDataSource: mockRemoteDataSource,
    networkInfo: mockNetworkinfo,
  );

  void runTestOnline(Function body) {
    group("device is online", () {
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

  group("Get Cities List", () {
    List<CityModel> tCitiesList = [
      CityModel(
          cityArabicName: "بارما",
          cityId: "1",
          countryId: "1",
          cityImage:
              "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
          cityEnglishName: 'Parma')
    ];

    //online
    runTestOnline(() {
      test("should chek if the device is online", () async {
        // arrange
        when(() => mockRemoteDataSource.getCitiesList(tCountryId))
            .thenAnswer((_) async => tCitiesList);
        // act
        await repostiry.getCitiesList(tCountryId);
        // assert
        verify(() => mockNetworkinfo.isConnected);
      });

      //-----

      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        // arrange
        when(() => mockRemoteDataSource.getCitiesList(tCountryId))
            .thenAnswer((_) async => tCitiesList);
        //act
        final result = await repostiry.getCitiesList(tCountryId);
        // assert
        verify(() => mockRemoteDataSource.getCitiesList(tCountryId));
        expect(result, equals(Right(tCitiesList)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getCitiesList(tCountryId))
            .thenThrow(ServerException());
        // act
        final result = await repostiry.getCitiesList(tCountryId);
        // assert
        verify(() => mockRemoteDataSource.getCitiesList(tCountryId));
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    // offline

    runTestOffline(() {
      test("should return error message there is no connection", () async {
        // arrange
        when(() => mockRemoteDataSource.getCitiesList(tCountryId))
            .thenThrow(ServerException());
        // act
        final result = await repostiry.getCitiesList(tCountryId);
        // assert
        verify(() =>mockNetworkinfo.isConnected  );
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
