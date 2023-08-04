import 'dart:convert';

import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:injectable/injectable.dart';

import '../models/itunes_lookup_response.dart';
import '../models/itunes_lookup_result_data_model.dart';
import 'json_to_album_list_mapper.dart';

@Injectable(as: JsonToAlbumListMapper)
class JsonToAlbumListMapperImpl implements JsonToAlbumListMapper {
  @override
  List<Album> map(String jsonString) {
    return ItunesLookupResponse.fromJson(jsonDecode(jsonString))
            .results
            ?.where(
              (element) =>
                  element.wrapperType == 'collection' &&
                  element.collectionType == 'Album',
            )
            .map(_mapAlbum)
            .toList() ??
        List.empty();
  }

  Album _mapAlbum(ItunesLookupResultDataModel dataModel) => Album(
        name: dataModel.collectionName ?? '',
        imageUrl: dataModel.artworkUrl100 ?? '',
        collectionPrice: dataModel.collectionPrice,
        currency: dataModel.currency ?? '',
      );
}
