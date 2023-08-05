import 'package:flutter/material.dart';

import '../models/album.dart';
import 'like_button.dart';

class AlbumListTile extends StatelessWidget {
  const AlbumListTile({super.key, required this.album});

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
      trailing: const LikeButton(isLiked: false, onPressed: null),
    );
  }
}
