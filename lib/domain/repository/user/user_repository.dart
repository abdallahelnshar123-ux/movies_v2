import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';

import '../../failure/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, Option<MyUser>>> getUserFromRemoteDataSource({required String uId});

  Future<Either<Failure, Unit>> createUser({required MyUser user});
}
