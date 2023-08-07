import 'package:equatable/equatable.dart';

import '../models/album.dart';

enum AlbumListStatus {
  initial,
  success,
  error;

  bool get isInitial => this == AlbumListStatus.initial;
  bool get isSuccess => this == AlbumListStatus.success;
  bool get isError => this == AlbumListStatus.error;
}

final class AlbumListState extends Equatable {
  const AlbumListState({
    this.status = AlbumListStatus.initial,
    this.albums = const [],
    this.canLoadMore = true,
    this.favoriteAlbums = const {},
  });

  final AlbumListStatus status;
  final List<Album> albums;
  final bool canLoadMore;
  final Set<int> favoriteAlbums;

  AlbumListState copyWith({
    AlbumListStatus? status,
    List<Album>? albums,
    bool? canLoadMore,
    Set<int>? favoriteAlbums,
  }) {
    return AlbumListState(
      status: status ?? this.status,
      albums: albums ?? this.albums,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      favoriteAlbums: favoriteAlbums ?? this.favoriteAlbums,
    );
  }

  @override
  List<Object?> get props => [status, albums, canLoadMore, favoriteAlbums];
}
