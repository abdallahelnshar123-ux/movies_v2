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
import '../../data/data_sources/remote/movie/impl/movie_remote_data_source_impl.dart'
    as _i343;
import '../../data/data_sources/remote/movie/movie_remote_data_source.dart'
    as _i525;
import '../../data/data_sources/remote/user/impl/user_remote_data_source_impl.dart'
    as _i22;
import '../../data/data_sources/remote/user/user_remote_data_source.dart'
    as _i632;
import '../../data/data_sources/remote/watchlist/impl/watchlist_remote_data_source_impl.dart'
    as _i643;
import '../../data/data_sources/remote/watchlist/watchlist_remote_data_source.dart'
    as _i569;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/movie/movie_repository_impl.dart' as _i98;
import '../../data/repository/user/user_repository_impl.dart' as _i1053;
import '../../data/repository/watchlist/watchlist_repository_impl.dart'
    as _i883;
import '../../data/services/firebase_auth_service.dart' as _i734;
import '../../data/services/firestore_service.dart' as _i367;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/movie/movie_repository.dart' as _i128;
import '../../domain/repository/user/user_repository.dart' as _i183;
import '../../domain/repository/watchlist/watchlist_repository.dart' as _i593;
import '../../domain/use_cases/add_movie_to_watchlist_use_case.dart' as _i981;
import '../../domain/use_cases/delete_movie_from_watchlist_use_case.dart'
    as _i327;
import '../../domain/use_cases/get_home_movies_use_case.dart' as _i766;
import '../../domain/use_cases/get_movie_details_use_case.dart' as _i368;
import '../../domain/use_cases/get_movie_suggestions_use_case.dart' as _i35;
import '../../domain/use_cases/get_movies_by_genre_use_case.dart' as _i452;
import '../../domain/use_cases/get_movies_by_search_use_case.dart' as _i23;
import '../../domain/use_cases/get_watchlist_movies_use_case.dart' as _i448;
import '../../domain/use_cases/login_with_email_and_password_use_case.dart'
    as _i1065;
import '../../domain/use_cases/register_with_email_and_password_use_case.dart'
    as _i904;
import '../../domain/use_cases/signin_with_gogole_use_cases.dart' as _i614;
import '../../features/ui/auth/cubit/auth_view_model.dart' as _i303;
import '../../features/ui/home_screen/tabs/browse_tab/cubit/browse_view_model.dart'
    as _i882;
import '../../features/ui/home_screen/tabs/home_tab/cubit/home_tab__carousel_view_model.dart'
    as _i44;
import '../../features/ui/home_screen/tabs/home_tab/cubit/home_tab_genre_view_model.dart'
    as _i189;
import '../../features/ui/home_screen/tabs/profile_tab/cubit/watchlist_view_model.dart'
    as _i222;
import '../../features/ui/home_screen/tabs/search_tab/cubit/search_view_model.dart'
    as _i301;
import '../../features/ui/movie_details_screen/cubit/movie_details_view_model.dart'
    as _i365;
import '../../features/ui/movie_details_screen/view/widget/movie_suggestions_widget/cubit/movie_suggestions_view_model.dart'
    as _i866;
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
    gh.factory<_i569.WatchlistRemoteDataSource>(
      () => _i643.WatchlistRemoteDataSourceImpl(gh<_i367.FirestoreService>()),
    );
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
    gh.factory<_i593.WatchlistRepository>(
      () =>
          _i883.WatchlistRepositoryImpl(gh<_i569.WatchlistRemoteDataSource>()),
    );
    gh.factory<_i996.UserLocalDataSource>(
      () => _i111.UserLocalDataSourceImpl(gh<_i1020.LocalStorage>()),
    );
    gh.factory<_i984.ApiConsumer>(() => _i44.DioConsumer(gh<_i361.Dio>()));
    gh.factory<_i981.AddMovieToWatchlistUseCase>(
      () => _i981.AddMovieToWatchlistUseCase(gh<_i593.WatchlistRepository>()),
    );
    gh.factory<_i327.DeleteMovieFromWatchlistUseCase>(
      () => _i327.DeleteMovieFromWatchlistUseCase(
        gh<_i593.WatchlistRepository>(),
      ),
    );
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
    gh.factory<_i448.GetWatchlistMoviesUseCase>(
      () => _i448.GetWatchlistMoviesUseCase(gh<_i593.WatchlistRepository>()),
    );
    gh.factory<_i222.WatchListCubit>(
      () => _i222.WatchListCubit(
        gh<_i448.GetWatchlistMoviesUseCase>(),
        gh<_i981.AddMovieToWatchlistUseCase>(),
        gh<_i327.DeleteMovieFromWatchlistUseCase>(),
      ),
    );
    gh.factory<_i525.MovieRemoteDataSource>(
      () => _i343.MovieRemoteDataSourceImpl(gh<_i984.ApiConsumer>()),
    );
    gh.factory<_i303.AuthCubit>(
      () => _i303.AuthCubit(
        gh<_i614.SignInWithGoogleUseCases>(),
        gh<_i904.RegisterWithEmailAndPasswordUseCase>(),
        gh<_i1065.LoginWithEmailAndPasswordUseCase>(),
      ),
    );
    gh.factory<_i128.MovieRepository>(
      () => _i98.MovieRepositoryImpl(gh<_i525.MovieRemoteDataSource>()),
    );
    gh.factory<_i766.GetHomeMoviesUseCase>(
      () => _i766.GetHomeMoviesUseCase(gh<_i128.MovieRepository>()),
    );
    gh.factory<_i368.GetMovieDetailsUseCase>(
      () => _i368.GetMovieDetailsUseCase(gh<_i128.MovieRepository>()),
    );
    gh.factory<_i35.GetMovieSuggestionsUseCase>(
      () => _i35.GetMovieSuggestionsUseCase(gh<_i128.MovieRepository>()),
    );
    gh.factory<_i452.GetMoviesByGenreUseCase>(
      () => _i452.GetMoviesByGenreUseCase(gh<_i128.MovieRepository>()),
    );
    gh.factory<_i23.GetMoviesBySearchUseCase>(
      () => _i23.GetMoviesBySearchUseCase(gh<_i128.MovieRepository>()),
    );
    gh.factory<_i882.BrowseCubit>(
      () => _i882.BrowseCubit(gh<_i452.GetMoviesByGenreUseCase>()),
    );
    gh.factory<_i189.HomeTabGenreCubit>(
      () => _i189.HomeTabGenreCubit(gh<_i452.GetMoviesByGenreUseCase>()),
    );
    gh.factory<_i365.MovieDetailsCubit>(
      () => _i365.MovieDetailsCubit(gh<_i368.GetMovieDetailsUseCase>()),
    );
    gh.factory<_i44.HomeTabCarouselCubit>(
      () => _i44.HomeTabCarouselCubit(gh<_i766.GetHomeMoviesUseCase>()),
    );
    gh.factory<_i866.MovieSuggestionsCubit>(
      () => _i866.MovieSuggestionsCubit(gh<_i35.GetMovieSuggestionsUseCase>()),
    );
    gh.factory<_i301.SearchCubit>(
      () => _i301.SearchCubit(gh<_i23.GetMoviesBySearchUseCase>()),
    );
    return this;
  }
}

class _$GetItModule extends _i834.GetItModule {}
