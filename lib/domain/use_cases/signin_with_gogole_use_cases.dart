import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';
import 'package:movies/domain/repository/auth/auth_repository.dart';

import '../failure/failure.dart';

@injectable
class SignInWithGoogleUseCases {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCases(this._authRepository);

  Future<Either<Failure, MyUser>> invoke() {
    return _authRepository.signInWithGoogle();
  }
}
