
import '../../../domain/entities/response/movie/movie.dart';

class MovieDetailsState {}

class MovieDetailsInitState extends MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final Movie movie;

  MovieDetailsSuccessState({required this.movie});
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String message;

  MovieDetailsErrorState({required this.message});
}

class MovieDetailsLoadingState extends MovieDetailsState {}
