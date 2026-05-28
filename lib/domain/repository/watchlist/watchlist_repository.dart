import 'package:dartz/dartz.dart';

import '../../entities/response/movie/movie.dart';
import '../../failure/failure.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, Unit>> addMovie({
    required Movie movie,
    required String uId,
  });

  Future<Either<Failure, Unit>> deleteMovie({
    required Movie movie,
    required String uId,
  });

  Stream<Either<Failure, List<Movie>>> getWatchListMovies({
    required String uId,
  });
}
