import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/user/user_remote_data_source.dart';
import 'package:movies/data/mapper/exception_mapper.dart';
import 'package:movies/data/mapper/my_user_dto_mapper.dart';
import 'package:movies/data/mapper/my_user_mapper.dart';
import 'package:movies/data/model/response/my_user_dto.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';
import 'package:movies/domain/repository/user/user_repository.dart';

import '../../../domain/failure/failure.dart';
import '../../exceptions/app_exceptions.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<Either<Failure, Option<MyUser>>> getUserFromRemoteDataSource({
    required String uId,
  }) async {
    try {
      final MyUserDto? userDto = await _userRemoteDataSource.getUser(uId);
      return userDto != null ? Right(Some(userDto.toUser())) : Right(None());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUser({required MyUser user}) async {
    try {
      await _userRemoteDataSource.createUser(user.toMyUserDto());
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser({required String uId}) async {
    try {
      await _userRemoteDataSource.deleteUser(uId);
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser({required MyUser user}) async {
    try {
     await _userRemoteDataSource.updateUser(user.toMyUserDto());
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
