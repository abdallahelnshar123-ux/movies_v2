abstract class HomeTabState {}

class HomeTabInitState extends HomeTabState {}
class HomeMoviesLoadingState extends HomeTabState {}

class HomeMoviesSuccessState extends HomeTabState {}

class HomeMoviesErrorState extends HomeTabState {
  final String message;

  HomeMoviesErrorState(this.message);
}
