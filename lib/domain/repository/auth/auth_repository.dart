import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/response/auth/auth_user.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';

import '../../failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, MyUser>> signInWithGoogle();

  Future<Either<Failure, MyUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  });
}
