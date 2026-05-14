
import 'package:movies/domain/entities/response/movie/cast.dart';
import 'package:movies/domain/entities/response/movie/torrents.dart';


class Movie {
  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.screenshots ,
    // this.mediumScreenshotImage1,
    // this.mediumScreenshotImage2,
    // this.mediumScreenshotImage3,
    // this.largeScreenshotImage1,
    // this.largeScreenshotImage2,
    // this.largeScreenshotImage3,
    this.cast,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,

  });

  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  int? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
List<String?>? screenshots ;
  // String? mediumScreenshotImage1;
  // String? mediumScreenshotImage2;
  // String? mediumScreenshotImage3;
  // String? largeScreenshotImage1;
  // String? largeScreenshotImage2;
  // String? largeScreenshotImage3;
  List<Cast>? cast;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;
}
