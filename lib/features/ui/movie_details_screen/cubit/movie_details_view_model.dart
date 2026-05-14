import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/use_cases/get_movie_details_use_case.dart';

import '../movie_details_state.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;

  MovieDetailsCubit(this._getMovieDetailsUseCase)
    : super(MovieDetailsInitState());

  Future<void> getMovieDetails({required int movieId,}) async {
    emit(MovieDetailsLoadingState());

    final result = await _getMovieDetailsUseCase.invoke(movieId: movieId);

    result.fold(
      (failure) => emit(MovieDetailsErrorState(message: failure.message)),
      (dataBaseMovie) {
        emit(MovieDetailsSuccessState(movie: dataBaseMovie));
      },
    );
  }
}
