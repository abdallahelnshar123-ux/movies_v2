import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';
import '../repository/movie/movie_repository.dart';

@injectable
class GetMoviesBySearchUseCase {
  final MovieRepository _movieRepository;

  GetMoviesBySearchUseCase(this._movieRepository);

  Future<Either<Failure, List<Movie>>> invoke({
    required String searchTerm,
    required int page,
  }) async {
    return await _movieRepository.getMoviesBySearch(
      searchTerm: searchTerm,
      page: page,
    );
  }
}
