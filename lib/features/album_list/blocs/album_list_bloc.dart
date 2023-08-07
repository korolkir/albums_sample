import 'dart:async';

import 'package:albums_sample/features/album_list/repositories/album_list_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'album_list_bloc_settings.dart';
import 'album_list_event.dart';
import 'album_list_state.dart';

@injectable
class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final AlbumListBlocSettings _settings;
  final AlbumListRepository _albumsRepository;
  var _currentPage = 0;

  AlbumListBloc({
    required AlbumListRepository albumsRepository,
    required AlbumListBlocSettings settings,
  })  : _albumsRepository = albumsRepository,
        _settings = settings,
        super(const AlbumListState()) {
    on<LoadAlbumListEvent>(_loadAlbumList, transformer: droppable());
    on<ToggleFavoriteAlbumEvent>(_toggleFavoriteAlbum);
  }

  int get _currentLimit => (_currentPage + 1) * _settings.itemsAmountPerPage;

  Future<void> _loadAlbumList(
    LoadAlbumListEvent event,
    Emitter<AlbumListState> emit,
  ) async {
    if (state.canLoadMore) {
      try {
        final albums = await _albumsRepository.getAlbumList(_currentLimit);
        final isEndOfList = albums.length < _currentLimit;
        emit(
          state.copyWith(
            status: AlbumListStatus.success,
            albums: albums,
            canLoadMore: !isEndOfList,
          ),
        );
        if (!isEndOfList) {
          _currentPage++;
        }
      } catch (error, stackTrace) {
        emit(state.copyWith(status: AlbumListStatus.error));
        addError(error, stackTrace);
      }
    }
  }

  FutureOr<void> _toggleFavoriteAlbum(
    ToggleFavoriteAlbumEvent event,
    Emitter<AlbumListState> emit,
  ) {
    final index = event.index;
    final favoriteAlbums = Set.of(state.favoriteAlbums);
    if (favoriteAlbums.contains(index)) {
      favoriteAlbums.remove(index);
    } else {
      favoriteAlbums.add(index);
    }
    emit(state.copyWith(favoriteAlbums: favoriteAlbums));
  }
}
