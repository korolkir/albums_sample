import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/album.dart';
import 'album_like_button.dart';

class AlbumListTile extends StatelessWidget {
  const AlbumListTile({
    super.key,
    required this.album,
    required this.index,
    required this.isFavorite,
  });

  final bool isFavorite;
  final int index;
  final Album album;

  @override
  Widget build(BuildContext context) {
    const imageSize = 56.0;
    return ListTile(
      leading: Image.network(
        album.imageUrl,
        width: imageSize,
        height: imageSize,
        errorBuilder: (_, __, ___) => const Icon(
          Icons.image,
          size: imageSize,
        ),
      ),
      title: Text(
        album.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: album.collectionPrice == null
          ? null
          : Text('${album.collectionPrice} ${album.currency}'),
      trailing: AlbumLikeButton(
        isLiked: isFavorite,
        onPressed: () => context.read<AlbumListBloc>().add(
              ToggleFavoriteAlbumEvent(index: index),
            ),
      ),
    );
  }
}
