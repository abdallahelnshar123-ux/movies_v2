abstract class HomeTabCarouselState {}

class HomeCarouselInitState extends HomeTabCarouselState {}

class HomeCarouselLoadingState extends HomeTabCarouselState {}

class HomeCarouselSuccessState extends HomeTabCarouselState {}

class HomeCarouselErrorState extends HomeTabCarouselState {
  final String message;

  HomeCarouselErrorState(this.message);
}
