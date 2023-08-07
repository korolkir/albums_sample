import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/album_list_bloc.dart';
import '../blocs/album_list_event.dart';

class AlbumListErrorWidget extends StatelessWidget {
  const AlbumListErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          IconButton(
            onPressed: () => _tryAgain(context),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }

  void _tryAgain(BuildContext context) {
    context.read<AlbumListBloc>().add(const LoadAlbumListEvent());
  }
}
