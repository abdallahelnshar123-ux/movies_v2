// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../data/data_sources/local/user/impl/user_local_data_source_impl.dart'
    as _i111;
import '../../data/data_sources/local/user/user_local_data_source.dart'
    as _i996;
import '../../data/data_sources/remote/auth/auth_remote_data_source.dart'
    as _i202;
import '../../data/data_sources/remote/auth/impl/auth_remote_data_source_impl.dart'
    as _i646;
import '../../data/data_sources/remote/user/impl/user_remote_data_source_impl.dart'
    as _i22;
import '../../data/data_sources/remote/user/user_remote_data_source.dart'
    as _i632;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/user/user_repository_impl.dart' as _i1053;
import '../../data/services/firebase_auth_service.dart' as _i734;
import '../../data/services/firestore_service.dart' as _i367;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/user/user_repository.dart' as _i183;
import '../../domain/use_cases/login_with_email_and_password_use_case.dart'
    as _i1065;
import '../../domain/use_cases/register_with_email_and_password_use_case.dart'
    as _i904;
import '../../domain/use_cases/signin_with_gogole_use_cases.dart' as _i614;
import '../../features/ui/auth/cubit/auth_view_model.dart' as _i303;
import '../data_bases/api/api_consumer.dart' as _i984;
import '../data_bases/api/dio_consumer.dart' as _i44;
import '../data_bases/api/get_it_module.dart' as _i834;
import '../data_bases/cache/local_storage.dart' as _i1020;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
    gh.singleton<_i361.BaseOptions>(() => getItModule.baseOptions);
    gh.singleton<_i528.PrettyDioLogger>(() => getItModule.prettyDioLogger);
    gh.lazySingleton<_i1020.LocalStorage>(() => _i1020.LocalStorage());
    gh.lazySingleton<_i734.FirebaseAuthService>(
      () => _i734.FirebaseAuthService(),
    );
    gh.lazySingleton<_i367.FirestoreService>(() => _i367.FirestoreService());
    gh.factory<_i632.UserRemoteDataSource>(
      () => _i22.UserRemoteDataSourceImpl(gh<_i367.FirestoreService>()),
    );
    gh.factory<_i183.UserRepository>(
      () => _i1053.UserRepositoryImpl(gh<_i632.UserRemoteDataSource>()),
    );
    gh.singleton<_i361.Dio>(
      () => getItModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
      ),
    );
    gh.factory<_i202.AuthRemoteDataSource>(
      () => _i646.AuthRemoteDataSourceImpl(gh<_i734.FirebaseAuthService>()),
    );
    gh.factory<_i996.UserLocalDataSource>(
      () => _i111.UserLocalDataSourceImpl(gh<_i1020.LocalStorage>()),
    );
    gh.factory<_i984.ApiConsumer>(() => _i44.DioConsumer(gh<_i361.Dio>()));
    gh.factory<_i912.AuthRepository>(
      () => _i392.AuthRepositoryImpl(
        gh<_i202.AuthRemoteDataSource>(),
        gh<_i632.UserRemoteDataSource>(),
        gh<_i996.UserLocalDataSource>(),
      ),
    );
    gh.factory<_i1065.LoginWithEmailAndPasswordUseCase>(
      () => _i1065.LoginWithEmailAndPasswordUseCase(gh<_i912.AuthRepository>()),
    );
    gh.factory<_i904.RegisterWithEmailAndPasswordUseCase>(
      () =>
          _i904.RegisterWithEmailAndPasswordUseCase(gh<_i912.AuthRepository>()),
    );
    gh.factory<_i614.SignInWithGoogleUseCases>(
      () => _i614.SignInWithGoogleUseCases(gh<_i912.AuthRepository>()),
    );
    gh.factory<_i303.AuthCubit>(
      () => _i303.AuthCubit(
        gh<_i614.SignInWithGoogleUseCases>(),
        gh<_i904.RegisterWithEmailAndPasswordUseCase>(),
        gh<_i1065.LoginWithEmailAndPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i834.GetItModule {}
