import '../../../model/response/auth_user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserDto?> signInWithGoogle();
}
