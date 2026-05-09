import '../../../model/response/auth_user_dto.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserDto> continueWithGoogle();

  Future<AuthUserDto> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
}
