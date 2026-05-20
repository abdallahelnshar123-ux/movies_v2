import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';
import '../repository/watchlist/watchlist_repository.dart';

@injectable
class GetWatchlistMoviesUseCase {
  final WatchlistRepository _watchListRepository;

  GetWatchlistMoviesUseCase(this._watchListRepository);

  Stream<Either<Failure, List<Movie>>> invoke({required String uId}) {
    return _watchListRepository.getWatchListMovies(uId: uId);
  }
}
