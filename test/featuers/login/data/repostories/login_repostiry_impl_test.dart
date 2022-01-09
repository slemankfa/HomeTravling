import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/login/data/datasource/login_remote_data_source.dart';
import 'package:home_travling/featuers/login/data/repostoires/login_repostiry_impl.dart';
import 'package:home_travling/featuers/login/domain/repositories/login_repositry.dart';
import 'package:mocktail/mocktail.dart';

import '../../../user_information.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockLoginRemoteDatasource extends Mock implements LoginRemoteDataSource {}

void main() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockLoginRemoteDatasource mockLoginRemoteDatasource =
      MockLoginRemoteDatasource();

  LoginRepositryImpl repositry = LoginRepositryImpl(
      networkInfo: mockNetworkInfo,
      loginRemoteDataSource: mockLoginRemoteDatasource);

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

  group("Sign in withEmail", () {
    runTestOnline(() {
      test("should check if the device is online", () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithEmail(
            tUserEmail, tUserPassword)).thenAnswer((_) async => tUserModel);

        // act
        await repositry.signInWithEmail(tUserEmail, tUserPassword);

        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      //-----

      test(
          "should return remote data when the call from remote data source us Successful ",
          () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithEmail(
            tUserEmail, tUserPassword)).thenAnswer((_) async => tUserModel);

        // act
        final result =
            await repositry.signInWithEmail(tUserEmail, tUserPassword);

        // act
        verify(() => mockLoginRemoteDatasource.signInWithEmail(
            tUserEmail, tUserPassword));
        expect(result, Right(tUserModel));
      });

      //---

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithEmail(
            tUserEmail, tUserPassword)).thenThrow(ServerException());

        // act
        final result =
            await repositry.signInWithEmail(tUserEmail, tUserPassword);

        // assert
        verify(() => mockNetworkInfo.isConnected);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    // ---

    runTestOffline(() {
      test("should return error message there is no connection", () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithEmail(
            tUserEmail, tUserPassword)).thenThrow(ServerException());
        // act
        final result =
            await repositry.signInWithEmail(tUserEmail, tUserPassword);
        // assert
        verify(() => mockNetworkInfo.isConnected);
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });

  group("Sign in Google", () {
    runTestOnline(() {
      test("should check if the device is online", () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithGoogle())
            .thenAnswer((_) async => tUserModel);

        // act
        await repositry.signInWithGoogle();

        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      //-----

      test(
          "should return remote data when the call from remote data source us Successful ",
          () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithGoogle())
            .thenAnswer((_) async => tUserModel);

        // act
        final result = await repositry.signInWithGoogle();

        // act
        verify(() => mockLoginRemoteDatasource.signInWithGoogle());
        expect(result, Right(tUserModel));
      });

      //---

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithGoogle())
            .thenThrow(ServerException());

        // act
        final result = await repositry.signInWithGoogle();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    // ---

    runTestOffline(() {
      test("should return error message there is no connection", () async {
        // arrange
        when(() => mockLoginRemoteDatasource.signInWithGoogle())
            .thenThrow(ServerException());
        // act
        final result = await repositry.signInWithGoogle();
        // assert
        verify(() => mockNetworkInfo.isConnected);
        // verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
