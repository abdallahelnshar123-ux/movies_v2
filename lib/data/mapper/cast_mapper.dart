
import 'package:movies/data/model/response/movie/movie_details_response/cast_dto.dart';
import 'package:movies/domain/entities/response/movie/cast.dart';

extension CastMapper on CastDto{
  Cast toCast(){
    return Cast(
      imdbCode: imdbCode,
      name: name,
      characterName: characterName ,
      urlSmallImage: urlSmallImage,

    );

  }

}