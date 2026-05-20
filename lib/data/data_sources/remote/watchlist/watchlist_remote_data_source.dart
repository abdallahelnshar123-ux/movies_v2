
import '../../../model/response/movie/movie_dto.dart';

abstract class WatchlistRemoteDataSource {

  Future<void> addMovieToWatchList({
    required MovieDto movie,
    required String uId,
  }) ;
  Future<void> deleteMovieFromWatchList({
    required MovieDto movie,
    required String uId,
  });



  Stream<List<MovieDto>> getWatchListMovies({
    required String uId,
  });

}