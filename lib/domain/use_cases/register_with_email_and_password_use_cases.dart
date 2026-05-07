import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/entities/response/auth/my_user.dart';
import 'package:movies/domain/failure/failure.dart';
import 'package:movies/domain/repository/auth/auth_repository.dart';


@injectable
class RegisterWithEmailAndPasswordUseCases {
  final AuthRepository _authRepository;

  RegisterWithEmailAndPasswordUseCases(this._authRepository);

  Future<Either<Failure, MyUser>> invoke({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) {
    return _authRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
      avatarIndex: avatarIndex,
      phone: phone,
      name: name,
    );
  }
}
