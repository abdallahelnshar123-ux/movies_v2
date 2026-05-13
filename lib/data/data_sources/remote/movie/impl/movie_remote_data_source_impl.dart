import 'package:injectable/injectable.dart';
import 'package:movies/core/data_bases/api/api_consumer.dart';
import 'package:movies/core/data_bases/api/end_points.dart';
import 'package:movies/data/data_sources/remote/movie/movie_remote_data_source.dart';
import 'package:movies/data/model/response/movies_response/all_movies_response_dto.dart';
import 'package:movies/data/model/response/movies_response/movie_dto.dart';

@Injectable(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiConsumer _apiConsumer;

  MovieRemoteDataSourceImpl(this._apiConsumer);

  @override
  Future<List<MovieDto>?> getHomeMovies() async {
    var response = await _apiConsumer.get<Map<String, dynamic>>(
      EndPoints.movieListEndPoint,
      queryParameters: {'limit': 19},
    );
    return AllMoviesResponseDto.fromJson(response).data?.movies;
  }

  @override
  Future<List<MovieDto>?> getMoviesByGenre({required String genre , required int page})async {
    var response = await _apiConsumer.get<Map<String, dynamic>>(
      EndPoints.movieListEndPoint,
      queryParameters: {'genre': genre , 'page' : page},
    );
    return AllMoviesResponseDto.fromJson(response).data?.movies;
  }
}
