import 'dart:async';

import 'package:albums_sample/features/album_list/repositories/album_list_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'album_list_bloc_settings.dart';
import 'album_list_event.dart';
import 'album_list_state.dart';

@injectable
class AlbumListBloc extends Bloc<LoadAlbumListEvent, AlbumListState> {
  final AlbumListBlocSettings _settings;
  final AlbumListRepository _albumsRepository;
  var _currentPage = 0;

  AlbumListBloc({
    required AlbumListRepository albumsRepository,
    required AlbumListBlocSettings settings,
  })  : _albumsRepository = albumsRepository,
        _settings = settings,
        super(const AlbumsLoaded(albums: [], canLoadMore: true)) {
    on<LoadAlbumListEvent>(_loadAlbumList, transformer: droppable());
  }

  int get _currentLimit => (_currentPage + 1) * _settings.itemsAmountPerPage;

  Future<void> _loadAlbumList(
    LoadAlbumListEvent event,
    Emitter<AlbumListState> emit,
  ) async {
    emit(const Loading());
    try {
      final albums = await _albumsRepository.getAlbumList(_currentLimit);
      final isEndOfList = albums.length < _currentLimit;
      emit(AlbumsLoaded(albums: albums, canLoadMore: !isEndOfList));
      if (!isEndOfList) {
        _currentPage++;
      }
    } catch (error, stackTrace) {
      emit(const Error());
      addError(error, stackTrace);
    }
  }
}
