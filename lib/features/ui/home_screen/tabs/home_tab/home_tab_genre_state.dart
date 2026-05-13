abstract class HomeTabGenreState {}

class HomeGenreInitState extends HomeTabGenreState {}

class HomeGenreLoadingState extends HomeTabGenreState {}

class HomeGenrePaginationLoadingState extends HomeTabGenreState {}

class HomeGenreSuccessState extends HomeTabGenreState {}

class HomeGenreErrorState extends HomeTabGenreState {
  final String message;

  HomeGenreErrorState(this.message);
}
