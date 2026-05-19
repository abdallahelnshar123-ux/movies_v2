import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/remote/history/history_remote_data_source.dart';
import 'package:movies/data/mapper/movie_mapper.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/domain/failure/failure.dart';

import '../../../domain/repository/history/history_repository.dart';
import '../../exceptions/app_exceptions.dart';
import '../../mapper/exception_mapper.dart';

@Injectable(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource _historyRemoteDataSource;

  HistoryRepositoryImpl(this._historyRemoteDataSource);

  @override
  Stream<Either<Failure, List<Movie>>> getHistoryMovies({required String uId}) {
    try {
      return _historyRemoteDataSource
          .getHistoryMovies(uId: uId)
          .map(
            (moviesDto) =>
                Right(moviesDto.map((movieDto) => movieDto.toMovie()).toList()),
          );
    } on AppException catch (e) {
      return Stream.value(Left(e.toFailure()));
    } catch (e) {
      return Stream.value(Left(UnexpectedFailure(e.toString())));
    }
  }
}
