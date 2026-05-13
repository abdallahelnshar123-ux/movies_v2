import 'package:movies/data/model/response/movies_response/movie_dto.dart';

abstract class MovieRemoteDataSource {
  Future <List<MovieDto>?> getHomeMovies();
  Future <List<MovieDto>?> getMoviesByGenre({required String genre , required int page});


}