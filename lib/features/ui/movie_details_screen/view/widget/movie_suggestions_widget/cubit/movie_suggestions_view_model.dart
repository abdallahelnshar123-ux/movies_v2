import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:movies/domain/use_cases/get_movie_suggestions_use_case.dart';

import '../movie_suggestions_state.dart';

@injectable
class MovieSuggestionsCubit extends Cubit<MovieSuggestionsState> {
  final GetMovieSuggestionsUseCase _getMovieSuggestionsUseCase;

  MovieSuggestionsCubit(this._getMovieSuggestionsUseCase)
    : super(MovieSuggestionsInitState());

  Future<void> getMovieSuggestions({required int movieId,}) async {
    emit(MovieSuggestionsLoadingState());

    final result = await _getMovieSuggestionsUseCase.invoke(movieId: movieId);

    result.fold(
      (failure) => emit(MovieSuggestionsErrorState(message: failure.message)),
      (moviesList) {
        emit(MovieSuggestionsSuccessState(movieList: moviesList));
      },
    );
  }
}
