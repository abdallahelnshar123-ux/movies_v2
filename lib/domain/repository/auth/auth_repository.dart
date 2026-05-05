import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/response/auth/my_user.dart';

import '../../failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, MyUser>> signInWithGoogle();

}