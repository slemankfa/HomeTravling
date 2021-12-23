import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  MockInternetConnectionChecker internetConnectionChecker =
      MockInternetConnectionChecker();
  NetworkInfoImpl networkInfo = NetworkInfoImpl(internetConnectionChecker);

  group("isConnected", () {
    test("should forward the call to internetConnectionChecker.hasConnection",
        () {
      // arrange
      final tHasConnection = Future.value(true);
      when(() => internetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnection);
      // act
      // NOTICE: We're NOT awaiting the result
      final result = networkInfo.isConnected;
      // assert
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      verify(() => internetConnectionChecker.hasConnection);
      expect(result, tHasConnection);
    });
  });
}
