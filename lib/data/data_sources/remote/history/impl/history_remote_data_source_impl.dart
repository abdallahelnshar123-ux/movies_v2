import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/model/response/movie/movie_dto.dart';

import '../../../../exceptions/app_exceptions.dart';
import '../../../../services/firestore_service.dart';
import '../history_remote_data_source.dart';

@Injectable(as: HistoryRemoteDataSource)
class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirestoreService _firestoreService;

  HistoryRemoteDataSourceImpl(this._firestoreService);

  @override
  Future<void> addMovieToHistory({
    required MovieDto movie,
    required String uId,
  }) async {
    try {
      return await _firestoreService.addMovieToHistory(movie: movie, uId: uId);
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'server_error');
    } on SocketException {
      throw NetworkException(message: 'no_internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Stream<List<MovieDto>> getHistoryMovies({required String uId}) {
    return _firestoreService.getHistoryMovies(uId: uId).handleError((error) {
      if (error is FirebaseException) {
        throw ServerException(message: error.message ?? 'server_error');
      } else if (error is SocketException) {
        throw NetworkException(message: 'no_internet');
      } else {
        throw UnexpectedException(message: error.toString());
      }
    });
  }
}
