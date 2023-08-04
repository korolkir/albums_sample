import '../models/album.dart';

abstract interface class AlbumListRepository {
  Future<List<Album>> getAlbumList(int limit);
}
