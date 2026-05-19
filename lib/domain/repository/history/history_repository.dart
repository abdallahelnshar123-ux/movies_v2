import 'package:dartz/dartz.dart';

import '../../entities/response/movie/movie.dart';
import '../../failure/failure.dart';

abstract class HistoryRepository {
  Stream<Either<Failure, List<Movie>>> getHistoryMovies({required String uId});
}
