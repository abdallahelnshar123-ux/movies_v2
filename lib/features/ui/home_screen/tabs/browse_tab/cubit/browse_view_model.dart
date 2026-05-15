import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/constants/app_constants.dart';
import 'package:movies/domain/use_cases/get_movies_by_genre_use_case.dart';

import '../../../../../../domain/entities/response/movie/movie.dart';
import '../browse_state.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  final GetMoviesByGenreUseCase _getMoviesByGenreUseCase;

  BrowseCubit(this._getMoviesByGenreUseCase) : super(BrowseInitialState());
  late String selectedGenre = AppConstants.genresList.first;

  int currentPage = 1;

  bool hasReachedMax = false;
  bool isFetching = false;
  List<Movie> moviesList = [];

  Future<void> getBrowseMovies({bool isPagination = false}) async {
    if (isFetching || hasReachedMax) return;

    isFetching = true;

    if (!isPagination) {
      currentPage = 1;
      hasReachedMax = false;
      moviesList.clear();

      emit(BrowseLoadingState());
    } else {
      emit(
        BrowseSuccessState(moviesList: moviesList, isPaginationLoading: true),
      );
    }

    final result = await _getMoviesByGenreUseCase.invoke(
      genre: selectedGenre,
      page: currentPage,
    );

    result.fold(
      (failure) {
        emit(BrowseErrorState(failure.message));
      },
      (listOfMovies) {
        if (listOfMovies.isEmpty) {
          hasReachedMax = true;
        } else {
          currentPage++;

          moviesList.addAll(listOfMovies);
        }

        emit(
          BrowseSuccessState(
            moviesList: moviesList,
            isPaginationLoading: false,
          ),
        );
      },
    );

    isFetching = false;
  }

  Future<void> getBrowseMoviesFromHomeTab({required String genre}) async {
    selectedGenre = genre;
    emit(BrowseLoadingState());
    currentPage = 1;
    hasReachedMax = false;
    moviesList.clear();

    final result = await _getMoviesByGenreUseCase.invoke(
      genre: genre,
      page: currentPage,
    );

    result.fold(
      (failure) {
        emit(BrowseErrorState(failure.message));
      },
      (listOfMovies) {
        if (listOfMovies.isEmpty) {
          hasReachedMax = true;
        } else {
          currentPage++;

          moviesList.addAll(listOfMovies);
        }

        emit(
          BrowseSuccessState(
            moviesList: moviesList,
            isPaginationLoading: false,
          ),
        );
      },
    );
  }

  void changeGenre(int index) {
    selectedGenre = AppConstants.genresList[index];
  }
}
