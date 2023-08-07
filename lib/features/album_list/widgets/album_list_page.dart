import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/di/get_it_configuration.dart';
import '../blocs/album_list_bloc.dart';
import '../blocs/album_list_event.dart';
import 'album_list_view.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Jack Johnson Albums'),
      ),
      body: BlocProvider<AlbumListBloc>(
        create: (_) => injector()..add(const LoadAlbumListEvent()),
        child: const AlbumListView(),
      ),
    );
  }
}
