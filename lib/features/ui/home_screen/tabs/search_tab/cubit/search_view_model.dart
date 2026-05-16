import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/use_cases/get_movies_by_search_use_case.dart';

import '../../../../../../domain/entities/response/movie/movie.dart';
import '../search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final GetMoviesBySearchUseCase _getMoviesBySearchUseCase;

  SearchCubit(this._getMoviesBySearchUseCase) : super(SearchInitialState());

  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;

  bool hasReachedMax = false;
  bool isFetching = false;
  String searchTerm = '';
  List<Movie> moviesList = [];

  void emitInitialState() {
    moviesList.clear();
    searchTerm = '';
    currentPage = 1;
    hasReachedMax = false;
    isFetching = false;
    emit(SearchInitialState());
  }

  Future<void> getSearchMovies({
    bool isPagination = false,
    // required String searchTerm,
  }) async {
    if (isFetching || hasReachedMax) return;

    isFetching = true;

    if (!isPagination) {
      currentPage = 1;
      hasReachedMax = false;
      moviesList.clear();

      emit(SearchLoadingState());
    } else {
      emit(
        SearchSuccessState(moviesList: moviesList, isPaginationLoading: true),
      );
    }

    final result = await _getMoviesBySearchUseCase.invoke(
      page: currentPage,
      searchTerm: searchTerm,
    );

    result.fold(
      (failure) {
        if (failure.message == 'no_movies_for_this_search_term') {
          emit(SearchEmptyState());
        } else {
          emit(SearchErrorState(failure.message));
        }
      },
      (listOfMovies) {
        if (listOfMovies.isEmpty) {
          hasReachedMax = true;
        } else {
          currentPage++;

          moviesList.addAll(listOfMovies);
        }

        emit(
          SearchSuccessState(
            moviesList: moviesList,
            isPaginationLoading: false,
          ),
        );
      },
    );

    isFetching = false;
  }
}
