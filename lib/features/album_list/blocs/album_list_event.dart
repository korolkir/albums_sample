import 'package:equatable/equatable.dart';

sealed class AlbumListEvent extends Equatable {
  const AlbumListEvent();

  @override
  List<Object?> get props => [];
}

final class LoadAlbumListEvent extends AlbumListEvent {
  const LoadAlbumListEvent();
}

final class ToggleFavoriteAlbumEvent extends AlbumListEvent {
  final int index;

  const ToggleFavoriteAlbumEvent({required this.index});

  @override
  List<Object?> get props => [index];
}
