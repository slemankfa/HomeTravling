import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/config.dart';
import 'package:home_travling/featuers/login/data/datasource/login_remote_data_source.dart';
import 'package:home_travling/featuers/login/data/models/user_model.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock.dart' as mock;
import '../../../user_information.dart';

class MockUserCredential extends Mock implements firebaseauth.UserCredential {}

class MockfirebaseAuth extends Mock implements firebaseauth.FirebaseAuth {}

// class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() async {
  // mock.setupFirebaseAuthMocks();

  // setUpAll(() async {
  //   await Firebase.initializeApp();
  // });

  UserModel tUserModel = UserModel(
      userId: "1",
      userName: "sleman",
      userImage: "image",
      userPassword: "",
      userEmail: "test@gmail.com",
      userToken: "1");

  final mockedUser = MockUser(
    isAnonymous: false,
    uid: '1',
    email: "test@gmail.com",
    displayName: 'sleman',
    photoURL: 'image',
  );

  final auth = MockFirebaseAuth(mockUser: mockedUser);
  MockfirebaseAuth mockfirebaseAuth = MockfirebaseAuth();

  /* 
Google Sign In
 */
  MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();

  LoginRemoteDataSourceImpl dataSource = LoginRemoteDataSourceImpl(
      firebaseAuth: auth, googleSignIn: mockGoogleSignIn);

  void setUpSigninWithEmail() async {
    final firebaseauth.UserCredential userCredential = await auth
        .signInWithEmailAndPassword(email: tUserEmail, password: tUserPassword);

    when(() => mockfirebaseAuth.signInWithEmailAndPassword(
        email: tUserEmail,
        password: tUserPassword)).thenAnswer((_) async => userCredential);
  }

  void setUpSigninWithGoogle() async {
    final signinAccount = await mockGoogleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final gooleMockedUser = MockUser(
      isAnonymous: false,
      uid: '1',
      email: "test@gmail.com",
      displayName: 'sleman',
      photoURL: 'image',
    );
    final mockGoogleAuth = MockFirebaseAuth(mockUser: gooleMockedUser);
    final result = await mockGoogleAuth.signInWithCredential(credential);

    when(() => mockfirebaseAuth.signInWithCredential(credential))
        .thenAnswer((_) async => result);
  }

  group("Sign in With google", () {
    test("should return a UserCredential to get userInformation ", () async {
      // arrange
      setUpSigninWithGoogle();
      // act
      dataSource.signInWithGoogle();
    });

    test("should return user information when from the UserCredential ",
        () async {
      // arrange
      setUpSigninWithGoogle();
      // act
      final result = await dataSource.signInWithGoogle();
      // assert
      // expect(result, equals(tUserModel));
      expect(result, equals(tUserModel));
    });
  });

  group("Sign in With email", () {
    test("should return a UserCredential user to get userInformation ",
        () async {
      // arrange
      setUpSigninWithEmail();
      // act
      dataSource.signInWithEmail(tUserEmail, tUserPassword);
    });

    test("should return user information when the UserCredential", () async {
      // arrange
      setUpSigninWithEmail();
      // act
      final result =
          await dataSource.signInWithEmail(tUserEmail, tUserPassword);
      // assert
      expect(result, equals(tUserModel));
    });
  });
}
