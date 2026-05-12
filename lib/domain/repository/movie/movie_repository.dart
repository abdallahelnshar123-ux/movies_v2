import 'package:dartz/dartz.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

import '../../failure/failure.dart';

abstract class MovieRepository {

  Future<Either<Failure,List<Movie>>> getHomeMovies();


}