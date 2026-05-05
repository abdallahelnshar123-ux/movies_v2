import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseAuthService {

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    await signIn.initialize(
      clientId:
      '503224830946-tm277q3ec3la0j61i5ds6dc222jhn6sf.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleAccount = await signIn.authenticate();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth = googleAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }

}