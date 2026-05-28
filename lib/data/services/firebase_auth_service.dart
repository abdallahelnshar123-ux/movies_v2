import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../exceptions/app_exceptions.dart';

@lazySingleton
class FirebaseAuthService {
  Future<AuthCredential> _getGoogleCredential() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    await signIn.initialize(
      clientId:
          '503224830946-tm277q3ec3la0j61i5ds6dc222jhn6sf.apps.googleusercontent.com',
    );

    final GoogleSignInAccount googleAccount = await signIn.authenticate();

    final GoogleSignInAuthentication googleAuth = googleAccount.authentication;

    return GoogleAuthProvider.credential(idToken: googleAuth.idToken);
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final credential = await _getGoogleCredential();

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw CancelledByUserException();
      }

      throw UnexpectedException(message: 'UnExpected Error');
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

  Future<UserCredential> reAuthenticate({required String password}) async {
    final user = FirebaseAuth.instance.currentUser;

    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );

    return await user.reauthenticateWithCredential(credential);
  }

  Future<void> deleteAccount() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<UserCredential> reAuthenticateWithGoogle() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw UnauthorizedException(message: 'User not authenticated');
      }

      final credential = await _getGoogleCredential();

      return await user.reauthenticateWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw CancelledByUserException();
      }

      throw UnexpectedException(message: 'Unexpected Error');
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
