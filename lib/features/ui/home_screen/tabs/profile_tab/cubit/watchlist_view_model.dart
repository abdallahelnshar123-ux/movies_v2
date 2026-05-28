import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/use_cases/add_movie_to_watchlist_use_case.dart';

import '../../../../../../domain/entities/response/movie/movie.dart';
import '../../../../../../domain/use_cases/delete_movie_from_watchlist_use_case.dart';
import '../../../../../../domain/use_cases/get_watchlist_movies_use_case.dart';
import '../watchlist_state.dart';

@injectable
class WatchListCubit extends Cubit<WatchListState> {
  final GetWatchlistMoviesUseCase _getWatchListMoviesUseCase;
  final AddMovieToWatchlistUseCase _addMovieToWatchlistUseCase;
  final DeleteMovieFromWatchlistUseCase _deleteMovieFromWatchlistUseCase;

  WatchListCubit(
    this._getWatchListMoviesUseCase,
    this._addMovieToWatchlistUseCase,
    this._deleteMovieFromWatchlistUseCase,
  ) : super(WatchListInitState());

  StreamSubscription? _subscription;

  List<Movie> watchListMovies = [];

  Set<int> watchListIds = {};

  void loadWatchList(String uId) {
    _subscription?.cancel();

    emit(WatchListLoadingState());

    _subscription = _getWatchListMoviesUseCase.invoke(uId: uId).listen((
      either,
    ) {
      either.fold(
        (failure) {
          emit(WatchListErrorState(failure.message));
        },

        (movies) {
          watchListMovies = movies;

          watchListIds = movies.map((movie) => movie.id ?? 0).toSet();
          if (watchListMovies.isEmpty) {
            emit(WatchListEmptyState());
            return;
          }
          emit(WatchListSuccessState(movies));
        },
      );
    });
  }

  Future<void> addMovie({required Movie movie, required String uId}) async {
    final result = await _addMovieToWatchlistUseCase.invoke(
      movie: movie,
      uId: uId,
    );

    result.fold((failure) {
      emit(WatchListErrorState(failure.message));
    }, (_) {});
  }

  Future<void> deleteMovie({required Movie movie, required String uId}) async {
    final result = await _deleteMovieFromWatchlistUseCase.invoke(
      movie: movie,
      uId: uId,
    );

    result.fold((failure) {
      emit(WatchListErrorState(failure.message));
    }, (_) {});
  }

  bool isMovieSaved(int movieId) {
    return watchListIds.contains(movieId);
  }

  Future<void> clearWatchList() async {
    _subscription?.cancel();

    watchListMovies.clear();
    watchListIds.clear();

    emit(WatchListInitState());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}
