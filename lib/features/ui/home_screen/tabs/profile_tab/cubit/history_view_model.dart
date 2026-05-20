import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/domain/use_cases/get_history_movies_use_case.dart';
import 'package:movies/features/ui/home_screen/tabs/profile_tab/history_state.dart';

import '../../../../../../domain/entities/response/movie/movie.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryMoviesUseCase _getHistoryMoviesUseCase;

  HistoryCubit(this._getHistoryMoviesUseCase) : super(HistoryInitState());

  StreamSubscription? _subscription;

  List<Movie> historyMovies = [];

  Set<int> watchListIds = {};

  void loadHistory(String uId) {
    _subscription?.cancel();

    emit(HistoryLoadingState());

    _subscription = _getHistoryMoviesUseCase.invoke(uId: uId).listen((either) {
      either.fold(
        (failure) {
          emit(HistoryErrorState(failure.message));
        },

        (movies) {
          historyMovies = movies;

          watchListIds = movies.map((movie) => movie.id ?? 0).toSet();
          if (historyMovies.isEmpty) {
            emit(HistoryEmptyState());
          }
          emit(HistorySuccessState(movies));
        },
      );
    });
  }
  Future<void> clearHistory() async{
    _subscription?.cancel();

    historyMovies.clear();
    watchListIds.clear();

    emit(HistoryInitState());
  }
  @override
  Future<void> close() {
    _subscription?.cancel();

    return super.close();
  }
}
