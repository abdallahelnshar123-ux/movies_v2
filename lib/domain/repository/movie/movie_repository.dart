import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

import '../../failure/failure.dart';

abstract class MovieRepository {

  Future<Either<Failure,List<Movie>>> getHomeMovies();
  Future<Either<Failure, List<Movie>>> getMoviesByGenre({required String genre , required int page});
  Future <Either<Failure, Movie>> getMovieDetails({ required int movieId});
  Future <Either<Failure, List<Movie>>> getMovieSuggestions({ required int movieId});



}