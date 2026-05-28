/// name : "Cherami Leigh"
/// character_name : "Pearl Serpentine"
/// url_small_image : "https://yts.bz/assets/images/actors/thumb/nm0473873.jpg"
/// imdb_code : "0473873"
library;

class CastDto {
  CastDto({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  CastDto.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }

  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }
}
