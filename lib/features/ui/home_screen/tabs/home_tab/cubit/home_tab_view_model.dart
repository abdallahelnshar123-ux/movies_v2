import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/domain/use_cases/get_home_movies_use_case.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/home_tab_state.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabState> {
  final GetHomeMoviesUseCase _getHomeMoviesUseCase;

  HomeTabCubit(this._getHomeMoviesUseCase) : super(HomeTabInitState());

  List<Movie> moviesList = [];

  void getHomeTabMovies() async {
    emit(HomeMoviesLoadingState());
    var result = await _getHomeMoviesUseCase.invoke();
    result.fold((failure) => emit(HomeMoviesErrorState(failure.message)), (
      listOfMovies,
    ) {
      moviesList = listOfMovies;
      emit(HomeMoviesSuccessState());
    });
  }
}
