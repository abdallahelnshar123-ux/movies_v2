/// status : "ok"
/// status_message : "Query was successful"
/// data : {"movie":{"id":5264,"url":"https://yts.bz/movies/monster-high-great-scarrier-reef-2016","imdb_code":"tt5475710","title":"Monster High: Great Scarrier Reef","title_english":"Monster High: Great Scarrier Reef","title_long":"Monster High: Great Scarrier Reef (2016)","slug":"monster-high-great-scarrier-reef-2016","year":2016,"rating":6.2,"runtime":71,"genres":["Action","Animation","Fantasy"],"like_count":25,"description_intro":"Lagoona returns to the sea where her life line is dying after struggling in an argument and not being able to let go of her traumatic childhood. She must compete in the sea dance contest and face off the Kraken with Frankie and the ghouls.","description_full":"Lagoona returns to the sea where her life line is dying after struggling in an argument and not being able to let go of her traumatic childhood. She must compete in the sea dance contest and face off the Kraken with Frankie and the ghouls.","yt_trailer_code":"kBhSQiO24tE","language":"en","mpa_rating":"Not Rated","background_image":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/background.jpg","background_image_original":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/background.jpg","small_cover_image":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/small-cover.jpg","medium_cover_image":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/medium-cover.jpg","large_cover_image":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/large-cover.jpg","medium_screenshot_image1":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/large-screenshot1.jpg","large_screenshot_image2":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/large-screenshot2.jpg","large_screenshot_image3":"https://yts.bz/assets/images/movies/monster_high_the_great_scarrier_reef_2016/large-screenshot3.jpg","cast":[{"name":"Cherami Leigh","character_name":"Pearl Serpentine","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm0473873.jpg","imdb_code":"0473873"},{"name":"Paula Rhodes","character_name":"Posea Reef","url_small_image":"https://yts.bz/assets/images/actors/thumb/nm1955206.jpg","imdb_code":"1955206"},{"name":"Salli Saffioti","character_name":"Clawdeen Wolf / Cleo de Nile","imdb_code":"1086483"},{"name":"Rachel Staman","character_name":"Peri Serpentine","imdb_code":"3113822"}],"torrents":[{"url":"https://yts.bz/torrent/download/3329CB3755577A3DFE4F29374ED94DD2B9F4F88C","hash":"3329CB3755577A3DFE4F29374ED94DD2B9F4F88C","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":2,"peers":4,"size":"527 MB","size_bytes":552599552,"date_uploaded":"2016-03-12 22:07:46","date_uploaded_unix":1457816866},{"url":"https://yts.bz/torrent/download/A1F5F8A0249226BCCEEE0E6E7FDAE871679D1879","hash":"A1F5F8A0249226BCCEEE0E6E7FDAE871679D1879","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":17,"peers":2,"size":"1.09 GB","size_bytes":1170378588,"date_uploaded":"2016-03-13 00:17:52","date_uploaded_unix":1457824672}],"date_uploaded":"2016-03-12 22:07:46","date_uploaded_unix":1457816866}}
/// @meta : {"api_version":2,"execution_time":"0 ms"}

library;

import '../meta_dto.dart';
import 'movie_details_data_dto.dart';
class MovieDetailsResponse {
  MovieDetailsResponse({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.meta,});

  MovieDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? MovieDetailsDataDto.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? MetaDto.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  MovieDetailsDataDto? data;
  MetaDto? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }

}







