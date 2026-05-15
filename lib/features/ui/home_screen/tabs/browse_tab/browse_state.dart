
import '../../../../../domain/entities/response/movie/movie.dart';

abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}
// class BrowsePaginationLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final List<Movie> moviesList;
  final bool isPaginationLoading;

  BrowseSuccessState({
    required this.moviesList,
    this.isPaginationLoading = false,
  });
}


class BrowseErrorState extends BrowseState {
  final String message;

  BrowseErrorState(this.message);
}
