import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/mapper/movie_dto_mapper.dart';
import 'package:movies/data/mapper/movie_mapper.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/domain/failure/failure.dart';

import '../../../domain/repository/watchlist/watchlist_repository.dart';
import '../../data_sources/remote/watchlist/watchlist_remote_data_source.dart';
import '../../exceptions/app_exceptions.dart';
import '../../mapper/exception_mapper.dart';

@Injectable(as: WatchlistRepository)
class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource _watchlistRemoteDataSource;

  WatchlistRepositoryImpl(this._watchlistRemoteDataSource);

  @override
  Future<Either<Failure, Unit>> addMovie({
    required Movie movie,
    required String uId,
  }) async {
    try {
      await _watchlistRemoteDataSource.addMovieToWatchList(
        movie: movie.toMovieDto(),
        uId: uId,
      );
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMovie({
    required Movie movie,
    required String uId,
  }) async {
    try {
      await _watchlistRemoteDataSource.deleteMovieFromWatchList(
        movie: movie.toMovieDto(),
        uId: uId,
      );
      return Right(unit);
    } on AppException catch (e) {
      return Left(e.toFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Movie>>> getWatchListMovies({
    required String uId,
  }) {
    try {
      return _watchlistRemoteDataSource
          .getWatchListMovies(uId: uId)
          .map(
            (moviesDto) =>
                Right(moviesDto.map((movieDto) => movieDto.toMovie()).toList()),
          );
    } on AppException catch (e) {
      return Stream.value(Left(e.toFailure()));
    } catch (e) {
      return Stream.value(Left(UnexpectedFailure(e.toString())));
    }
  }
}
