import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_page.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_view.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumListBloc extends MockBloc<AlbumListEvent, AlbumListState>
    implements AlbumListBloc {}

void main() {
  late AlbumListBloc mockAlbumsBlock;

  setUpAll(() async {
    mockAlbumsBlock = MockAlbumListBloc();
    when(() => mockAlbumsBlock.state).thenReturn(const AlbumListState());
    GetIt.instance.registerFactory<AlbumListBloc>(() => mockAlbumsBlock);
  });

  testWidgets(
    'AlbumListPage displays correctly',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AlbumListPage()));

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Jack Johnson Albums'), findsOneWidget);

      expect(find.byType(AlbumListView), findsOneWidget);
    },
  );
}
