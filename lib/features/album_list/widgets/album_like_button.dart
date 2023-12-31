import 'package:flutter/material.dart';

class AlbumLikeButton extends StatelessWidget {
  const AlbumLikeButton({super.key, required this.isLiked, this.onPressed});

  final bool isLiked;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked
            ? Theme.of(context).colorScheme.inversePrimary
            : Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}
