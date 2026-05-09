import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/auth/auth_remote_data_source.dart';
import 'package:movies/data/data_sources/remote/user/user_remote_data_source.dart';
import 'package:movies/data/exceptions/app_exceptions.dart';
import 'package:movies/data/exceptions/exception_mapper.dart';
import 'package:movies/data/mapper/auth_user_mapper.dart';
import 'package:movies/data/mapper/my_user_dto_mapper.dart';
import 'package:movies/domain/entities/response/auth/auth_user.dart';
import 'package:movies/data/model/response/my_user_dto.dart';
import 'package:movies/domain/entities/response/auth/auth_providers.dart';
import 'package:movies/domain/entities/response/user/my_user.dart';
import 'package:movies/domain/repository/auth/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/failure/failure.dart';
import '../../mapper/my_user_mapper.dart';
import '../../model/response/auth_user_dto.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._userRemoteDataSource);

  @override
  Future<Either<Failure, MyUser>> signInWithGoogle() async {
    // try {
    //   final AuthUserDto authUserDto = await _authRemoteDataSource.signInWithGoogle();
    //
    //   if (authUser == null) {
    //     return Left(AuthFailure("User cancelled"));
    //   }
    //
    //   final MyUserDto? firestoreUser = await _userRemoteDataSource.getUser(
    //     authUser.id,
    //   );
    //
    //   if (firestoreUser == null) {
    //     final newUser = MyUserDto(
    //       provider: AuthProviders.google,
    //       id: authUser.id,
    //       name: authUser.name,
    //       phone: authUser.phone,
    //       email: authUser.email,
    //       avatarIndex: -1,
    //     );
    //     await _userRemoteDataSource.createUser(newUser);
    //     return Right(newUser.toUser());
    //   }
    //
    //   return Right(firestoreUser.toUser());
    // } on AppException catch (e) {
    //   return Left(e.toFailure());
    // } catch (e) {
    //   return Left(UnexpectedFailure(e.toString()));
    // }
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MyUser>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    // return await authResult.fold(
    //       (failure) {
    //     return Left(failure);
    //   },
    //
    //       (authUser) async {
    //     final Either<Failure, Option<MyUser>> firestoreUser =
    //     await _userRepository.getUser(uId: authUser.id);
    //
    //     return firestoreUser.fold((failure) => Left(failure), (myUserOption) {
    //       return myUserOption.fold(
    //             () async {
    //           final newUser = MyUser(
    //             provider: AuthProviders.emailPassword,
    //             id: authUser.id,
    //             name: name,
    //             phone: phone,
    //             email: authUser.email,
    //             avatarIndex: avatarIndex,
    //           );
    //           await _userRepository.createUser(user: newUser);
    //           return Right(newUser);
    //         },
    //             (myUser) {
    //           return Right(myUser);
    //         },
    //       );
    //     });
    //   },
    // );
    try {
      final authUserDto = await _authRemoteDataSource
          .registerWithEmailAndPassword(email: email, password: password);

      // final MyUserDto? firestoreUser = await _userRemoteDataSource.getUser(
      //   authUserDto.id,
      // );
      //
      // if (firestoreUser != null) {
      //   return Left(AuthFailure('Email already Exist ,please login'));
      // }

      final newUser = MyUser(
        provider: AuthProviders.emailPassword,
        id: authUserDto.id,
        name: name,
        phone: phone,
        email: authUserDto.email,
        avatarIndex: avatarIndex,
      );
      await _userRemoteDataSource.createUser(newUser.toMyUserDto());



      return Right(newUser);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
    // try {
    //   final AuthUserDto authUserDto = await _authRemoteDataSource
    //       .registerWithEmailAndPassword(password: password, email: email);
    //
    //
    //   return Right(authUserDto.toAuthUser());
    // }
    // on AppException catch (e) {
    //   return Left(e.toFailure());
    // } catch (e) {
    //   return Left(UnexpectedFailure(e.toString()));
    // }
  }
}
