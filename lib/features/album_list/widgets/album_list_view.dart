import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/album_list_bloc.dart';
import '../blocs/album_list_event.dart';
import '../blocs/album_list_state.dart';
import '../models/album.dart';
import 'album_list_tile.dart';
import 'albums_loading_status.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({super.key});

  @override
  State<AlbumListView> createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  final ScrollController _scrollController = ScrollController();
  List<Album> _albums = List.empty();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _removeListener();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumListBloc, AlbumListState>(
      listenWhen: (_, state) => state is AlbumsLoaded || state is Error,
      listener: (_, state) => switch (state) {
        AlbumsLoaded(:final albums, :final canLoadMore) =>
          _onItemsLoaded(albums, canLoadMore),
        Error() => _removeListener(),
        _ => null
      },
      builder: (_, state) => _albums.isEmpty
          ? const AlbumsLoadingStatus()
          : ListView.separated(
              controller: _scrollController,
              itemCount: _getItemsCount(state),
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) => index == _albums.length
                  ? const AlbumsLoadingStatus()
                  : AlbumListTile(album: _albums[index]),
            ),
    );
  }

  void _removeListener() {
    _scrollController.removeListener(_scrollListener);
  }

  void _onItemsLoaded(List<Album> albums, bool canLoadMore) {
    setState(() {
      _albums = albums;
    });
    if (!canLoadMore) {
      _removeListener();
    }
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll * 0.9) {
      context.read<AlbumListBloc>().add(const LoadAlbumListEvent());
    }
  }

  int _getItemsCount(AlbumListState state) {
    if (state is AlbumsLoaded && !state.canLoadMore) {
      return _albums.length;
    }
    return _albums.length + 1;
  }
}
