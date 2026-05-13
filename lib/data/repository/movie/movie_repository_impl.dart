import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/movie/movie_remote_data_source.dart';
import 'package:movies/data/exceptions/app_exceptions.dart';
import 'package:movies/data/mapper/exception_mapper.dart';
import 'package:movies/data/mapper/movie_mapper.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/domain/failure/failure.dart';
import 'package:movies/domain/repository/movie/movie_repository.dart';

@Injectable(as: MovieRepository)
class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImpl(this._movieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getHomeMovies() async {
    try {
      var moviesList = await _movieRemoteDataSource.getHomeMovies();
      if (moviesList == null) {
        return Left(UnexpectedFailure('Sorry we could not load movies'));
      }
      return Right(moviesList.map((movieDto) => movieDto.toMovie()).toList());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on DioException catch (e) {
      var exception = e.error as AppException;

      return Left(exception.toFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenre({
    required String genre,
    required int page
  }) async {
    try {
      var moviesList = await _movieRemoteDataSource.getMoviesByGenre(
        genre: genre,
        page: page
      );
      if (moviesList == null) {
        return Left(UnexpectedFailure('Sorry we could not load movies'));
      }
      return Right(moviesList.map((movieDto) => movieDto.toMovie()).toList());
    } on AppException catch (e) {
      return Left(e.toFailure());
    } on DioException catch (e) {
      var exception = e.error as AppException;

      return Left(exception.toFailure());
    }
  }
}
