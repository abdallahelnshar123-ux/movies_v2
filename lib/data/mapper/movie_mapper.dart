import 'package:movies/data/mapper/cast_mapper.dart';
import 'package:movies/data/mapper/torrents_mapper.dart';
import 'package:movies/domain/entities/response/movie/movie.dart';

import '../model/response/movie/movie_dto.dart';

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
      titleEnglish: titleEnglish,
      titleLong: titleLong,
      url: url,
      year: year,
      ytTrailerCode: ytTrailerCode,
      cast: cast?.map((castDto) => castDto.toCast()).toList(),
      descriptionIntro: descriptionIntro,
      screenshots: [
        mediumScreenshotImage1 ?? largeScreenshotImage1,
        mediumScreenshotImage2 ?? largeScreenshotImage2,
        mediumScreenshotImage3 ?? largeScreenshotImage3
      ],
      // largeScreenshotImage1
      // :,
      // largeScreenshotImage2
      // :,
      // largeScreenshotImage3: largeScreenshotImage3,
      // likeCount: likeCount,
      // mediumScreenshotImage1
      // :,
      // mediumScreenshotImage2
      // :,
      // mediumScreenshotImage3: mediumScreenshotImage3,
      torrents: torrents
          ?.map((torrentsDto) => torrentsDto.toTorrents())
          .toList(),
    );
  }
}
