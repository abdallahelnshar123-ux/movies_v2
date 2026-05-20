import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../exceptions/app_exceptions.dart';

@lazySingleton
class FirebaseAuthService {
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(
        clientId:
            '503224830946-tm277q3ec3la0j61i5ds6dc222jhn6sf.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleAccount = await signIn.authenticate();
      final GoogleSignInAuthentication googleAuth =
          googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw CancelledByUserException();
      }

      rethrow;
    }
  }

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
