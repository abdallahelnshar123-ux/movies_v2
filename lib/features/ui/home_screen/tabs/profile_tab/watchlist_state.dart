import '../../../../../domain/entities/response/movie/movie.dart';

abstract class WatchListState {}

class WatchListLoadingState extends WatchListState {}
class WatchListEmptyState extends WatchListState {}

class WatchListSuccessState extends WatchListState {
  final List<Movie> movies;

  WatchListSuccessState(this.movies);
}

class WatchListErrorState extends WatchListState {
  final String message;

  WatchListErrorState(this.message);
}