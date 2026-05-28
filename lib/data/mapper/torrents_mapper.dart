import 'package:movies/data/model/response/movie/torrents_dto.dart';
import 'package:movies/domain/entities/response/movie/torrents.dart';

extension TorrentsMapper on TorrentsDto {
  Torrents toTorrents() {
    return Torrents(
      url: url,
      dateUploadedUnix: dateUploadedUnix,
      dateUploaded: dateUploaded,
      type: type,
      size: size,
      audioChannels: audioChannels,
      bitDepth: bitDepth,
      hash: hash,
      isRepack: isRepack,
      peers: peers,
      quality: quality,
      seeds: seeds,
      sizeBytes: sizeBytes,
      videoCodec: videoCodec,
    );
  }
}
