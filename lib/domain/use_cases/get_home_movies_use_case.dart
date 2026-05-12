import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/repository/movie/movie_repository.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';

@injectable
class GetHomeMoviesUseCase {
  final MovieRepository _movieRepository;

  GetHomeMoviesUseCase(this._movieRepository);

  Future<Either<Failure, List<Movie>>> invoke() async {
    return await _movieRepository.getHomeMovies();
  }
}
