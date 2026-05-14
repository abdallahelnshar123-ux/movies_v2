import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:movies/data/mapper/auth_user_dto_mapper.dart';
import 'package:movies/data/services/firebase_auth_service.dart';

import '../../../../exceptions/app_exceptions.dart';
import '../../../../model/response/auth_user_dto.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuthService _firebaseAuthService;

  AuthRemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<AuthUserDto> continueWithGoogle() async {
    try {
      final userCredential = await _firebaseAuthService.signInWithGoogle();
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? 'Firebase Auth Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AuthUserDto> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuthService
          .registerWithEmailAndPassword(email: email, password: password);
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw ServerException(
          message: 'the_email_address_is_already_in_use_by_another_account',
        );
      }
      throw ServerException(message: e.message ?? 'Firebase Auth Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<AuthUserDto> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuthService
          .loginWithEmailAndPassword(email: email, password: password);
      return userCredential.toAuthUserDto();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? 'Firebase Auth Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
