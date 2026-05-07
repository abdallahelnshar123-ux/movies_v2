import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:movies/data/model/response/auth_user_dto.dart';
import 'package:movies/data/services/firebase_auth_service.dart';

import '../../../../exceptions/app_exceptions.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuthService _firebaseAuthService;

  AuthRemoteDataSourceImpl(this._firebaseAuthService);

  @override
  Future<AuthUserDto?> signInWithGoogle() async {
    try {
      final userCredential = await _firebaseAuthService.signInWithGoogle();
      if (userCredential == null) return null;

      final AuthUserDto user = AuthUserDto(
        id: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
        name: userCredential.user?.displayName ?? '',
        phone: userCredential.user?.phoneNumber ?? '',
      );
      return user;
    } catch (e) {
      throw ServerException(message: e.toString());
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
      final AuthUserDto user = AuthUserDto(
        id: userCredential.user?.uid ?? '',
        email: userCredential.user?.email ?? '',
        name: userCredential.user?.displayName ?? '',
        phone: userCredential.user?.phoneNumber ?? '',
      );
      return user;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
