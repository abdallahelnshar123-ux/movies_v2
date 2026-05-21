

class FirebaseUtils {




  //
  // static Future<UserCredential?> reSignInWithGoogle() async {
  //   final GoogleSignIn signIn = GoogleSignIn.instance;
  //   await signIn.initialize(
  //     clientId:
  //         '503224830946-tm277q3ec3la0j61i5ds6dc222jhn6sf.apps.googleusercontent.com',
  //   );
  //
  //   final GoogleSignInAccount? googleUser = await signIn.authenticate();
  //   if (googleUser != null) {
  //     final GoogleSignInAuthentication googleAuth = googleUser.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     return await FirebaseAuth.instance.currentUser!
  //         .reauthenticateWithCredential(credential);
  //   }
  //
  //   return null;
  // }
}
