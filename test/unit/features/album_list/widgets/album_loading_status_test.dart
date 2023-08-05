import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/widgets/albums_loading_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumListBloc extends MockBloc<LoadAlbumListEvent, AlbumListState>
    implements AlbumListBloc {}

extension on WidgetTester {
  Future<void> pumpAlbumsLoadingStatus(AlbumListBloc postBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: postBloc,
          child: const Material(child: AlbumsLoadingStatus()),
        ),
      ),
    );
  }
}

void main() {
  late AlbumListBloc albumsBloc;

  setUp(() {
    albumsBloc = MockAlbumListBloc();
  });

  testWidgets(
    'AlbumsLoadingStatus displays Error widget when state is Error',
    (WidgetTester tester) async {
      when(() => albumsBloc.state).thenReturn(const Error());

      await tester.pumpAlbumsLoadingStatus(albumsBloc);

      // Verify that the Error widget is displayed.
      expect(find.text('Error'), findsOneWidget);

      // Verify that the CircularProgressIndicator is not displayed.
      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );

  testWidgets(
    'AlbumsLoadingStatus displays CircularProgressIndicator '
    'When state is not Error',
    (WidgetTester tester) async {
      when(() => albumsBloc.state).thenReturn(const Loading());

      await tester.pumpAlbumsLoadingStatus(albumsBloc);

      // Verify that the CircularProgressIndicator is displayed.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Verify that the Error widget is not displayed.
      expect(find.text('Error'), findsNothing);
    },
  );
}
