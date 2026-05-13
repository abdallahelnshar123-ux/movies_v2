import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';
import '../repository/movie/movie_repository.dart';

@injectable
class GetMoviesByGenreUseCase {
  final MovieRepository _movieRepository;

  GetMoviesByGenreUseCase(this._movieRepository);

  Future<Either<Failure, List<Movie>>> invoke({required String genre , required int page}) async {
    return await _movieRepository.getMoviesByGenre(genre: genre , page: page);
  }
}
