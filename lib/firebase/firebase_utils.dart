

class FirebaseUtils {

  //
  // static Future<void> updateUserDataToFirestore(MyUser user) async {
  //   var querySnapshot = getUsersCollection().doc(user.id);
  //   await querySnapshot.update(user.toFireStore());
  // }
  //
  // static Future<void> deleteUserFromFirestore(String uId) async {
  //   await getUsersCollection().doc(uId).delete();
  // }
  //
  // ///  watch List =========================================================

  //
  // /// sign in ==============================================================
  //

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
