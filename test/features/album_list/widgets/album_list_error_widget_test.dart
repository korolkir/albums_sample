import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_error_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumListBloc extends MockBloc<AlbumListEvent, AlbumListState>
    implements AlbumListBloc {}

extension on WidgetTester {
  Future<void> pumpAlbumListErrorWidget(AlbumListBloc albumsBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: albumsBloc,
          child: const Material(child: AlbumListErrorWidget()),
        ),
      ),
    );
  }
}

void main() {
  group('AlbumListErrorWidget Tests', () {
    late AlbumListBloc albumsBloc;

    setUp(() {
      albumsBloc = MockAlbumListBloc();
    });

    testWidgets(
      'Verify error widget content',
      (WidgetTester tester) async {
        await tester.pumpAlbumListErrorWidget(albumsBloc);

        // Verify that the error text widget is displayed.
        expect(find.text('Error'), findsOneWidget);

        // Verify that the icon button is displayed.
        expect(find.byType(IconButton), findsOneWidget);

        // Verify that the refresh_rounded icon is displayed.
        expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
      },
    );

    testWidgets(
      'When click on icon button '
      'Then add LoadAlbumListEvent to the Bloc',
      (WidgetTester tester) async {
        await tester.pumpAlbumListErrorWidget(albumsBloc);

        // Perform click on icon button
        await tester.tap(find.byType(IconButton));

        // Verify that the LoadAlbumListEvent is added.
        verify(() => albumsBloc.add(const LoadAlbumListEvent())).called(1);
      },
    );
  });
}
