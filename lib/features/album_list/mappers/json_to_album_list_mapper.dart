import '../models/album.dart';

abstract interface class JsonToAlbumListMapper {
  List<Album> map(String jsonString);
}
