import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/album_list_bloc.dart';
import '../blocs/album_list_event.dart';
import '../blocs/album_list_state.dart';
import 'album_list_error_widget.dart';
import 'album_list_loading_widget.dart';
import 'album_list_tile.dart';

class AlbumListView extends StatefulWidget {
  const AlbumListView({super.key});

  @override
  State<AlbumListView> createState() => _AlbumListViewState();
}

class _AlbumListViewState extends State<AlbumListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumListBloc, AlbumListState>(
      builder: (_, state) {
        if (state.status.isInitial) {
          return const AlbumListLoadingWidget();
        } else if (state.status.isSuccess && state.albums.isEmpty) {
          return const Center(child: Text('No albums'));
        } else if (state.status.isError && state.albums.isEmpty) {
          return const AlbumListErrorWidget();
        } else {
          return ListView.separated(
            controller: _scrollController,
            itemCount: state.canLoadMore
                ? state.albums.length + 1
                : state.albums.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) {
              if (index == state.albums.length) {
                return state.status.isError
                    ? const AlbumListErrorWidget()
                    : const AlbumListLoadingWidget();
              }
              return AlbumListTile(
                album: state.albums[index],
                index: index,
                isFavorite: state.favoriteAlbums.contains(index),
              );
            },
          );
        }
      },
    );
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll * 0.9) {
      context.read<AlbumListBloc>().add(const LoadAlbumListEvent());
    }
  }
}
