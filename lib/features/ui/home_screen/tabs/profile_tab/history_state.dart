import '../../../../../domain/entities/response/movie/movie.dart';

abstract class HistoryState {}

class HistoryInitState extends HistoryState {}
class HistoryLoadingState extends HistoryState {}

class HistoryEmptyState extends HistoryState {}

class HistorySuccessState extends HistoryState {
  final List<Movie> movies;

  HistorySuccessState(this.movies);
}

class HistoryErrorState extends HistoryState {
  final String message;

  HistoryErrorState(this.message);
}
