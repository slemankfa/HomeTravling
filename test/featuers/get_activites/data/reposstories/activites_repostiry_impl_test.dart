import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/get_activites/data/datasource/activites_remote_data_source.dart';
import 'package:home_travling/featuers/get_activites/data/model/activity_model.dart';
import 'package:home_travling/featuers/get_activites/data/repositories/activites_repostiry_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../activites_list.dart';
import '../../../cities_list.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockActivitiesRemoteDatasource extends Mock
    implements ActivitiesRemoteDataSource {}

void main() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockActivitiesRemoteDatasource mockRemoteDatasource =
      MockActivitiesRemoteDatasource();

  final instaance = FakeFirebaseFirestore();
  const tCityId = "2";

  ActivitiesRepostiryImpl repostiry = ActivitiesRepostiryImpl(
    networkInfo: mockNetworkInfo,
    activitiesRemoteDataSource: mockRemoteDatasource,
  );

  void runTestOnline(Function body) {
    group("device is online", () {
      setUpAll(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUpAll(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("Get Activites List", () {
    List<ActivityModel> tActivitesList = [
      ActivityModel(
          cityId: "2",
          countryId: "3",
          activityTypeId: "2",
          activityId: "3",
          activityDescription:
              "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine.",
          activityImage:
              "https://i.pinimg.com/originals/dc/87/67/dc876709b8d32bb0b388af21dce7e755.jpg",
          activityEnglishName:
              "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine",
          activityArbaicName: "زواج فلسطيني تقليدي")
    ];

    // online
    runTestOnline(() {
      test("should check if the device is online", () async {
        // arrange
        when(() => mockRemoteDatasource.getActivitiesList(tCityId))
            .thenAnswer((_) async => tActivitesList);
        // act
        await repostiry.getActivitesList(tCityId);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      //-----
      test(
          "should return remote data when the call to remote data source us Successfu",
          () async {
        // arrange
        when(() => mockRemoteDatasource.getActivitiesList(tCityId))
            .thenAnswer((_) async => tActivitesList);
        // act
        final result = await repostiry.getActivitesList(tCityId);

        // assert
        verify(() => mockRemoteDatasource.getActivitiesList(tCityId));
        expect(result, equals(Right(tActivitesList)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockRemoteDatasource.getActivitiesList(tCityId))
            .thenThrow(ServerException());
        // act
        final result = await repostiry.getActivitesList(tCityId);
        // assert
        verify(() => mockRemoteDatasource.getActivitiesList(tCityId));
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    // offline
    runTestOffline(() {
      test("should return error message there is no connection", () async {
        // arrange
        when(() => mockRemoteDatasource.getActivitiesList(tCityId))
            .thenThrow(ServerException());
        // act
        final result = await repostiry.getActivitesList(tCityId);
        // assert
        verify(() => mockNetworkInfo.isConnected);
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
