import 'package:movies/data/model/response/movie/movie_dto.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

extension MovieDtoMapper on Movie {
  MovieDto toMovieDto() {
    return MovieDto(
      dateUploaded: dateUploaded,
      dateUploadedUnix: dateUploadedUnix,
      descriptionFull: descriptionFull,
      genres: genres,
      imdbCode: imdbCode,
      language: language,
      largeCoverImage: largeCoverImage,
      mediumCoverImage: mediumCoverImage,
      mpaRating: mpaRating,
      rating: rating,
      runtime: runtime,
      smallCoverImage: smallCoverImage,
      titleEnglish: titleEnglish,
      titleLong: titleLong,
      url: url,
      year: year,
      ytTrailerCode: ytTrailerCode,
      descriptionIntro: descriptionIntro,
      id: id,
      title: title,
      slug: slug,
      backgroundImage: backgroundImage,
      backgroundImageOriginal: backgroundImageOriginal,
      likeCount: likeCount,
    );
  }
}
