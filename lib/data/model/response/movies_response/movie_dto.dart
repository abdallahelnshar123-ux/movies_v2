/// id : 76237
/// url : "https://yts.bz/movies/the-christophers-2025"
/// imdb_code : "tt34966562"
/// title : "The Christophers"
/// title_english : "The Christophers"
/// title_long : "The Christophers (2025)"
/// slug : "the-christophers-2025"
/// year : 2025
/// rating : 7.2
/// runtime : 100
/// genres : ["كوميديا","دراما"]
/// summary : "The children of a once famous artist hire a forger to complete some unfinished, long ago abandoned canvases so they'll have an inheritance when he dies."
/// description_full : "The children of a once famous artist hire a forger to complete some unfinished, long ago abandoned canvases so they'll have an inheritance when he dies."
/// synopsis : "The children of a once famous artist hire a forger to complete some unfinished, long ago abandoned canvases so they'll have an inheritance when he dies."
/// yt_trailer_code : "42GkXhRVLUQ"
/// language : "en"
/// mpa_rating : "R"
/// background_image : "https://yts.bz/assets/images/movies/the_christophers_2025/background.jpg"
/// background_image_original : "https://yts.bz/assets/images/movies/the_christophers_2025/background.jpg"
/// small_cover_image : "https://yts.bz/assets/images/movies/the_christophers_2025/small-cover.jpg"
/// medium_cover_image : "https://yts.bz/assets/images/movies/the_christophers_2025/medium-cover.jpg"
/// large_cover_image : "https://yts.bz/assets/images/movies/the_christophers_2025/large-cover.jpg"
/// state : "ok"
/// torrents : [{"url":"https://yts.bz/torrent/download/4AF2A846755A98F2E08AA2E45D0951E3EB70B888","hash":"4AF2A846755A98F2E08AA2E45D0951E3EB70B888","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"919.22 MB","size_bytes":963872031,"date_uploaded":"2026-05-12 09:11:09","date_uploaded_unix":1778569869},{"url":"https://yts.bz/torrent/download/8284B2CCF852DE820017AD3BC10784AFDF6B19C2","hash":"8284B2CCF852DE820017AD3BC10784AFDF6B19C2","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.84 GB","size_bytes":1975684956,"date_uploaded":"2026-05-12 10:22:45","date_uploaded_unix":1778574165}]
/// date_uploaded : "2026-05-12 09:11:09"
/// date_uploaded_unix : 1778569869

library;

import 'package:movies/data/model/response/movies_response/torrents_dto.dart';

class MovieDto {
  MovieDto({
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
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  MovieDto.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = (json['rating'] as num?)?.toDouble();
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(TorrentsDto.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

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
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<TorrentsDto>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }
}
