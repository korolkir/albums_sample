import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/album_list_bloc.dart';
import '../blocs/album_list_event.dart';
import '../blocs/album_list_state.dart';

class AlbumsLoadingStatus extends StatelessWidget {
  const AlbumsLoadingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AlbumListBloc, AlbumListState>(
        builder: (_, state) => state is Error
            ? Row(
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
              )
            : const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }

  void _tryAgain(BuildContext context) {
    context.read<AlbumListBloc>().add(const LoadAlbumListEvent());
  }
}
