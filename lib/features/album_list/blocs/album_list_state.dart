import 'package:equatable/equatable.dart';

import '../models/album.dart';

sealed class AlbumListState extends Equatable {
  const AlbumListState();

  @override
  List<Object?> get props => [];
}

final class AlbumsLoaded extends AlbumListState {
  final List<Album> albums;
  final bool canLoadMore;

  const AlbumsLoaded({required this.albums, required this.canLoadMore});

  @override
  List<Object?> get props => [albums, canLoadMore];
}

final class Error extends AlbumListState {
  const Error();
}

final class Loading extends AlbumListState {
  const Loading();
}
