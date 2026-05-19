import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/model/response/movie/movie_dto.dart';

import '../../../../exceptions/app_exceptions.dart';
import '../../../../services/firestore_service.dart';
import '../watchlist_remote_data_source.dart';

@Injectable(as: WatchlistRemoteDataSource)
class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final FirestoreService _firestoreService;

  WatchlistRemoteDataSourceImpl(this._firestoreService);

  @override
  Future<void> addMovieToWatchList({
    required MovieDto movie,
    required String uId,
  }) async {
    try {
      return await _firestoreService.addMovieToWatchList(
        movie: movie,
        uId: uId,
      );
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Firestore Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Future<void> deleteMovieFromWatchList({
    required MovieDto movie,
    required String uId,
  }) async {
    try {
      return await _firestoreService.deleteMovieFromWatchList(
        movie: movie,
        uId: uId,
      );
    } on FirebaseException catch (e) {
      throw ServerException(message: e.message ?? 'Firestore Error');
    } on SocketException {
      throw NetworkException(message: 'No Internet');
    } catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  @override
  Stream<List<MovieDto>> getWatchListMovies({required String uId}) {
    return _firestoreService.getWatchListMovies(uId: uId).handleError((error) {
      if (error is FirebaseException) {
        throw ServerException(message: error.message ?? 'Firestore Error');
      } else if (error is SocketException) {
        throw NetworkException(message: 'No Internet');
      } else {
        throw UnexpectedException(message: error.toString());
      }
    });
  }
}
