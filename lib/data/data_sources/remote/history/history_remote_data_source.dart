import '../../../model/response/movie/movie_dto.dart';

abstract class HistoryRemoteDataSource {
  Future<void> addMovieToHistory({
    required MovieDto movie,
    required String uId,
  });

  Stream<List<MovieDto>> getHistoryMovies({required String uId});
}
