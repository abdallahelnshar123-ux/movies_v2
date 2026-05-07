import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:movies/data/data_sources/remote/user/user_remote_data_source.dart';
import 'package:movies/data/exceptions/app_exceptions.dart';
import 'package:movies/data/exceptions/exception_mapper.dart';
import 'package:movies/data/model/response/auth_user_dto.dart';
import 'package:movies/data/model/response/my_user_dto.dart';
import 'package:movies/domain/entities/response/auth/auth_providers.dart';
import 'package:movies/domain/entities/response/auth/my_user.dart';
import 'package:movies/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/failure/failure.dart';
import '../../mapper/my_user_mapper.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._userRemoteDataSource);

  @override
  Future<Either<Failure, MyUser>> signInWithGoogle() async {
    try {
      final AuthUserDto? authUser = await _authRemoteDataSource
          .signInWithGoogle();

      if (authUser == null) {
        return Left(AuthFailure("User cancelled"));
      }

      final MyUserDto? firestoreUser = await _userRemoteDataSource.getUser(
        authUser.id,
      );

      if (firestoreUser == null) {
        final newUser = MyUserDto(
          provider: AuthProviders.google,
          id: authUser.id,
          name: authUser.name,
          phone: authUser.phone,
          email: authUser.email,
          avatarIndex: -1,
        );
        await _userRemoteDataSource.createUser(newUser);
        return Right(newUser.toUser());
      }

      return Right(firestoreUser.toUser());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MyUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    try {
      final AuthUserDto authUser = await _authRemoteDataSource
          .registerWithEmailAndPassword(password: password, email: email);

      // if (authUser == null) {
      //   return Left(AuthFailure("User cancelled"));
      // }

      final MyUserDto? firestoreUser = await _userRemoteDataSource.getUser(
        authUser.id,
      );

      if (firestoreUser == null) {
        final newUser = MyUserDto(
          provider: AuthProviders.emailPassword,
          id: authUser.id,
          name: name,
          phone: phone,
          email: authUser.email,
          avatarIndex: avatarIndex,
        );
        await _userRemoteDataSource.createUser(newUser);
        return Right(newUser.toUser());
      }

      if (firestoreUser.provider == AuthProviders.google) {
        return Left(
          AuthFailure(
            'This Email Already exists , Please login through Google ',
          ),
        );
      }
      // if (firestoreUser.provider == AuthProviders.emailPassword) {
      //   return Left(
      //     AuthFailure(
      //       'This Email Already exists , Please login through email and password ',
      //     ),
      //   );
      // }
      return Left(
          AuthFailure(
            'This Email Already exists , Please login through email and password ',
          ));

      // return Right(firestoreUser.toUser());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
