import 'package:movies/data/model/response/movies_response/movie_dto.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

extension MovieMapper on MovieDto {
  Movie toMovie() {
    return Movie(
      id: id,
      title: title,
      slug: slug,
      backgroundImage: backgroundImage,
      backgroundImageOriginal: backgroundImageOriginal,
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
      state: state,
      summary: summary,
      synopsis: synopsis,
      titleEnglish: titleEnglish,
      titleLong: titleLong,
      url: url,
      year: year,
      ytTrailerCode: ytTrailerCode,
    );
  }
}
