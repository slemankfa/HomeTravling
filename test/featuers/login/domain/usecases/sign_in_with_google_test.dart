import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/login/domain/repositories/login_repositry.dart';
import 'package:home_travling/featuers/login/domain/usecases/sign_in_with_google.dart';
import 'package:mocktail/mocktail.dart';

import '../../../user_information.dart';

class MockLoginRepostiy extends Mock implements LoginRepostiry {}

void main() {
  MockLoginRepostiy mockLoginRepostiy = MockLoginRepostiy();
  SignInWithGoogle usecase = SignInWithGoogle(mockLoginRepostiy);

  test("should get user entity from the repostiry ", () async {
    // arrange
    when(() => mockLoginRepostiy.signInWithGoogle())
        .thenAnswer((_) async => Right(tUserEntity));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tUserEntity));
    verify(() => mockLoginRepostiy.signInWithGoogle());
    verifyNoMoreInteractions(mockLoginRepostiy);
  });
}
