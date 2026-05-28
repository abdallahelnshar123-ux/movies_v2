import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';
import '../repository/watchlist/watchlist_repository.dart';

@injectable
class AddMovieToWatchlistUseCase {
  final WatchlistRepository _watchlistRepository;

  AddMovieToWatchlistUseCase(this._watchlistRepository);

  Future<Either<Failure, Unit>> invoke({
    required Movie movie,
    required String uId,
  }) {
    return _watchlistRepository.addMovie(movie: movie, uId: uId);
  }
}
