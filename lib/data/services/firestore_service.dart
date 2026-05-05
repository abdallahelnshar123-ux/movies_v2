import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../model/response/my_user_dto.dart';

@lazySingleton
class FirestoreService {
  CollectionReference<MyUserDto> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUserDto.collectionName)
        .withConverter<MyUserDto>(
          fromFirestore: (snapshot, options) =>
              MyUserDto.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  Future<void> addUserToFireStore(MyUserDto myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  Future<MyUserDto?> getUserFromFireStore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
