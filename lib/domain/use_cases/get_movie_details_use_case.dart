import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/response/movie/movie.dart';
import '../failure/failure.dart';
import '../repository/movie/movie_repository.dart';

@injectable
class GetMovieDetailsUseCase {
  final MovieRepository _movieRepository;

  GetMovieDetailsUseCase(this._movieRepository);

  Future<Either<Failure, Movie>> invoke({required int movieId , required String uId}) async {
    return await _movieRepository.getMovieDetails(movieId: movieId ,uId: uId );
  }
}
