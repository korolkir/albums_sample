import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_error_widget.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_loading_widget.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_tile.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_view.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumListBloc extends MockBloc<LoadAlbumListEvent, AlbumListState>
    implements AlbumListBloc {}

extension on WidgetTester {
  Future<void> pumpAlbumsListView(AlbumListBloc albumListBloc) {
    return pumpWidget(
      MaterialApp(
        home: Material(
          child: BlocProvider.value(
            value: albumListBloc,
            child: const AlbumListView(),
          ),
        ),
      ),
    );
  }
}

void main() {
  group('AlbumListView Widget Tests', () {
    late MockAlbumListBloc mockBloc;
    const albums = [
      Album(
        name: 'album1',
        imageUrl: 'image1',
        collectionPrice: 9.99,
        currency: 'USD',
      ),
      Album(
        name: 'album2',
        imageUrl: 'image2',
        collectionPrice: 14.99,
        currency: 'USD',
      ),
    ];

    setUp(() {
      // Initialize the mock bloc before each test.
      mockBloc = MockAlbumListBloc();
    });

    testWidgets(
      'When status is initial '
      'Then display loading widget',
      (WidgetTester tester) async {
        // Stub the bloc state with initial state.
        when(() => mockBloc.state).thenReturn(const AlbumListState());

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Verify that the loading widget is displayed.
        expect(find.byType(AlbumListLoadingWidget), findsOneWidget);

        // Verify that the error widget is not displayed.
        expect(find.byType(AlbumListErrorWidget), findsNothing);

        // Verify that the list widget is not displayed.
        expect(find.byType(ListView), findsNothing);
      },
    );

    testWidgets(
      'When status is success && albums list is empty '
      'Then display no albums widget',
      (WidgetTester tester) async {
        // Stub the bloc state with initial state.
        when(() => mockBloc.state).thenReturn(
          const AlbumListState(status: AlbumListStatus.success),
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Verify that the no albums widget is displayed.
        expect(find.text('No albums'), findsOneWidget);

        // Verify that the loading widget is not displayed.
        expect(find.byType(AlbumListLoadingWidget), findsNothing);

        // Verify that the error widget is not displayed.
        expect(find.byType(AlbumListErrorWidget), findsNothing);

        // Verify that the list widget is not displayed.
        expect(find.byType(ListView), findsNothing);
      },
    );

    testWidgets(
      'When status is success with albums and canLoadMore = true '
      'Then display list with loading widget',
      (WidgetTester tester) async {
        // Stub the bloc state with the success state with canLoadMore = true.
        when(() => mockBloc.state).thenReturn(
          const AlbumListState(
            status: AlbumListStatus.success,
            albums: albums,
            canLoadMore: true,
          ),
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Verify that the correct number of AlbumListTile widgets is displayed.
        expect(find.byType(AlbumListTile), findsNWidgets(albums.length));

        // Verify that the widget is displayed.
        expect(find.byType(AlbumListLoadingWidget), findsOneWidget);

        // Verify that the error widget is not displayed.
        expect(find.byType(AlbumListErrorWidget), findsNothing);
      },
    );

    testWidgets(
      'When status is success with albums and canLoadMore = false '
      'Then display list without loading and error widgets',
      (WidgetTester tester) async {
        // Stub the bloc state with the success state with no more data.
        when(() => mockBloc.state).thenReturn(
          const AlbumListState(
            status: AlbumListStatus.success,
            albums: albums,
            canLoadMore: false,
          ),
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Verify that the correct number of AlbumListTile widgets is displayed.
        expect(find.byType(AlbumListTile), findsNWidgets(albums.length));

        // Verify that the loading widget is not displayed.
        expect(find.byType(AlbumListLoadingWidget), findsNothing);

        // Verify that the error widget is not displayed.
        expect(find.byType(AlbumListErrorWidget), findsNothing);
      },
    );

    testWidgets(
      'When status is error with empty albums '
      'Then display error widget',
      (WidgetTester tester) async {
        // Stub the bloc state with the error state.
        when(() => mockBloc.state).thenReturn(
          const AlbumListState(status: AlbumListStatus.error),
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Verify that the error widget is displayed.
        expect(find.byType(AlbumListErrorWidget), findsOneWidget);

        // Verify that the loading widget is not displayed.
        expect(find.byType(AlbumListLoadingWidget), findsNothing);

        // Verify that the list widget is not displayed.
        expect(find.byType(ListView), findsNothing);
      },
    );

    testWidgets(
      'When status is error and albums list is not empty '
      'Then display error widget at the end of list view',
      (WidgetTester tester) async {
        // Stub the bloc state with the success state with no more data.
        when(() => mockBloc.state).thenReturn(
          const AlbumListState(
            status: AlbumListStatus.error,
            albums: albums,
            canLoadMore: true,
          ),
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the correct number of AlbumListTile widgets is displayed.
        expect(find.byType(AlbumListTile), findsNWidgets(albums.length));

        // Verify that the error widget is displayed.
        expect(find.byType(AlbumListErrorWidget), findsOneWidget);

        // Verify that the loading widget is not displayed.
        expect(find.byType(AlbumListLoadingWidget), findsNothing);
      },
    );

    testWidgets(
      'When status is success and canLoadMore = true '
      'Then scroll down triggers loading more albums',
      (WidgetTester tester) async {
        // Prepare a list of albums for the success state.
        final albums = List.generate(
          10,
          (index) => Album(
            name: 'album$index',
            imageUrl: 'image$index',
            collectionPrice: 9.99,
            currency: 'USD',
          ),
        );

        // Stub the bloc state with the success state.
        when(() => mockBloc.state).thenReturn(
          AlbumListState(
            status: AlbumListStatus.error,
            albums: albums,
            canLoadMore: true,
          ),
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger the scroll down event.
        await tester.drag(find.byType(ListView), const Offset(0, -500));

        // Verify LoadAlbumListEvent event has been added to the Bloc.
        verify(() => mockBloc.add(const LoadAlbumListEvent())).called(1);
      },
    );
  });
}
