import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../mappers/json_to_album_list_mapper.dart';
import '../models/album.dart';
import 'album_list_repository.dart';

@Injectable(as: AlbumListRepository)
class ItunesAlbumListRepository implements AlbumListRepository {
  final Dio _dioClient;
  final JsonToAlbumListMapper _mapper;

  ItunesAlbumListRepository({
    required Dio dioClient,
    required JsonToAlbumListMapper mapper,
  })  : _dioClient = dioClient,
        _mapper = mapper;

  @override
  Future<List<Album>> getAlbumList(int limit) async {
    final response = await _dioClient.get(
      '/lookup',
      queryParameters: {
        'id': 909253,
        'entity': 'album',
        'limit': limit,
      },
    );
    return _mapper.map(response.data);
  }
}
