import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/login/domain/repositories/login_repositry.dart';
import 'package:home_travling/featuers/login/domain/usecases/sign_in_with_email.dart';
import 'package:mocktail/mocktail.dart';

import '../../../user_information.dart';

class MockLoginRepostiry extends Mock implements LoginRepostiry {}

void main() {
  MockLoginRepostiry mockLoginRepostiry = MockLoginRepostiry();
  SignInWithEmail usecase = SignInWithEmail(mockLoginRepostiry);

  test("Should get user enitity from the repostiry", () async {
    // arrange
    when(() => mockLoginRepostiry.signInWithEmail(tUserEmail, tUserPassword))
        .thenAnswer((_) async => Right(tUserEntity));
    // act
    final result = await usecase(
        SignInWithEmailParams(email: tUserEmail, password: tUserPassword));

    // assert
    expect(result, Right(tUserEntity));
    verify(() => mockLoginRepostiry.signInWithEmail(tUserEmail, tUserPassword));
    verifyNoMoreInteractions(mockLoginRepostiry);
  });
}
