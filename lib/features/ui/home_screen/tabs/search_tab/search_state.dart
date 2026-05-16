import '../../../../../domain/entities/response/movie/movie.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Movie> moviesList;
  final bool isPaginationLoading;

  SearchSuccessState({
    required this.moviesList,
    this.isPaginationLoading = false,
  });
}

class SearchEmptyState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}
