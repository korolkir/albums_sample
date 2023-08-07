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
  });

  final AlbumListStatus status;
  final List<Album> albums;
  final bool canLoadMore;

  AlbumListState copyWith({
    AlbumListStatus? status,
    List<Album>? albums,
    bool? canLoadMore,
  }) {
    return AlbumListState(
      status: status ?? this.status,
      albums: albums ?? this.albums,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }

  @override
  List<Object?> get props => [status, albums, canLoadMore];
}
