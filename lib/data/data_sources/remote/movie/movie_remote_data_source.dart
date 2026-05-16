
import '../../../model/response/movie/movie_dto.dart';

abstract class MovieRemoteDataSource {
  Future <List<MovieDto>?> getHomeMovies();
  Future <List<MovieDto>?> getMoviesByGenre({required String genre , required int page});
  Future <MovieDto?> getMovieDetails({ required int movieId});
  Future <List<MovieDto>?> getMovieSuggestions({ required int movieId});
  Future <List<MovieDto>?> getMoviesBySearch({required String searchTerm ,required int page});


}