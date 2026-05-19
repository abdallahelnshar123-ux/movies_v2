import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

import '../../failure/failure.dart';

abstract class MovieRepository {

  Future<Either<Failure,List<Movie>>> getHomeMovies();
  Future<Either<Failure, List<Movie>>> getMoviesByGenre({required String genre , required int page});
  Future <Either<Failure, Movie>> getMovieDetails({ required int movieId ,required String uId});
  Future <Either<Failure, List<Movie>>> getMovieSuggestions({ required int movieId});
  Future <Either<Failure,List<Movie>>> getMoviesBySearch({required String searchTerm ,required int page});



}