

import '../../../../../../domain/entities/response/movie/movie.dart';

class MovieSuggestionsState {}

class MovieSuggestionsInitState extends MovieSuggestionsState {}

class MovieSuggestionsSuccessState extends MovieSuggestionsState {
  final List<Movie> movieList;

  MovieSuggestionsSuccessState({required this.movieList});
}

class MovieSuggestionsErrorState extends MovieSuggestionsState {
  final String message;

  MovieSuggestionsErrorState({required this.message});
}

class MovieSuggestionsLoadingState extends MovieSuggestionsState {}
