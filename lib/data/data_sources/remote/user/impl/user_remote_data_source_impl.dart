import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../exceptions/app_exceptions.dart';
import '../../../../model/response/my_user_dto.dart';
import '../../../../services/firestore_service.dart';
import '../user_remote_data_source.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirestoreService _firestoreService;

  UserRemoteDataSourceImpl(this._firestoreService);

  @override
  Future<MyUserDto?> getUser(String uId) async {
    try {
      return await _firestoreService.getUserFromFireStore(uId);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Firestore Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> createUser(MyUserDto user) async {
    try {
      return await _firestoreService.addUserToFireStore(user);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Firestore Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> deleteUser(String uId) async {
    try {
       await _firestoreService.deleteUserFromFirestore(uId);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Firestore Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> updateUser(MyUserDto user) async {
    try {
      await _firestoreService.updateUserDataToFirestore(user);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Firestore Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
