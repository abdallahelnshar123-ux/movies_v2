import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';
import 'package:movies/domain/use_cases/get_movies_by_genre_use_case.dart';
import 'package:movies/features/ui/home_screen/tabs/home_tab/home_tab_genre_state.dart';

import '../../../../../../core/constants/app_constants.dart';

@injectable
class HomeTabGenreCubit extends Cubit<HomeTabGenreState> {
  final GetMoviesByGenreUseCase _getMoviesByGenreUseCase;

  HomeTabGenreCubit(this._getMoviesByGenreUseCase)
    : super(HomeGenreInitState());
  var random = Random();
  String randomGenre = '';

  List<Movie> moviesList = [];
  int currentPage = 1;

  bool isLoading = false;

  bool hasReachedMax = false;

  Future<void> getHomeTabGenreMovies({bool isPagination = false}) async {
    if (isLoading || hasReachedMax) return;

    isLoading = true;

    if (!isPagination) {
      randomGenre = AppConstants
          .genresList[random.nextInt(AppConstants.genresList.length)];

      currentPage = 1;

      hasReachedMax = false;

      moviesList.clear();

      emit(HomeGenreLoadingState());
    } else {
      emit(HomeGenrePaginationLoadingState());
    }

    final result = await _getMoviesByGenreUseCase.invoke(
      genre: randomGenre,
      page: currentPage,
    );

    result.fold(
      (failure) {
        emit(HomeGenreErrorState(failure.message));
      },
      (listOfMovies) {
        if (listOfMovies.isEmpty) {
          hasReachedMax = true;
        } else {
          currentPage++;

          moviesList.addAll(listOfMovies);
        }

        emit(HomeGenreSuccessState());
      },
    );

    isLoading = false;
  }
}
