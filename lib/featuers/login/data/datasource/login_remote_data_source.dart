import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_travling/featuers/login/data/models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signInWithGoogle();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  LoginRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    // TODO: implement signInWithEmail

    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return _getUserModel(userCredential);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    // await Firebase.initializeApp();
    GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await account?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return _getUserModel(userCredential);
  }

  UserModel _getUserModel(UserCredential userCredential) {
    return UserModel(
        userId: userCredential.user!.uid,
        userName: userCredential.user!.displayName ?? "",
        userImage: userCredential.user!.photoURL ?? "",
        userPassword: "",
        userEmail: userCredential.user!.email ?? "",
        userToken: userCredential.user!.uid);
  }
}
