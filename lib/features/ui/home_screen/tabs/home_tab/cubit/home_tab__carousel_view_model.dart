import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/domain/use_cases/get_home_movies_use_case.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/home_tab_carousel_state.dart';

@injectable
class HomeTabCarouselCubit extends Cubit<HomeTabCarouselState> {
  final GetHomeMoviesUseCase _getHomeMoviesUseCase;

  HomeTabCarouselCubit(this._getHomeMoviesUseCase)
    : super(HomeCarouselInitState());

  List<Movie> moviesList = [];

  void getHomeTabMovies() async {
    emit(HomeCarouselLoadingState());
    var result = await _getHomeMoviesUseCase.invoke();
    result.fold((failure) => emit(HomeCarouselErrorState(failure.message)), (
      listOfMovies,
    ) {
      moviesList = listOfMovies;
      emit(HomeCarouselSuccessState());
    });
  }
}
