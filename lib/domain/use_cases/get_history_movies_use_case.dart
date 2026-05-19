import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/repository/history/history_repository.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';

@injectable
class GetHistoryMoviesUseCase {
  final HistoryRepository _historyRepository;

  GetHistoryMoviesUseCase(this._historyRepository);

  Stream<Either<Failure, List<Movie>>> invoke({required String uId}) {
    return _historyRepository.getHistoryMovies(uId: uId);
  }
}
