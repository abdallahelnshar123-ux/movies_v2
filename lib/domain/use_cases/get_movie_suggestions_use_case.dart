import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';
import '../repository/movie/movie_repository.dart';

@injectable
class GetMovieSuggestionsUseCase {
  final MovieRepository _movieRepository;

  GetMovieSuggestionsUseCase(this._movieRepository);

  Future<Either<Failure, List<Movie>>> invoke({required int movieId}) async {
    return await _movieRepository.getMovieSuggestions(movieId: movieId);
  }
}
