import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_tile.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_view.dart';
import 'package:albums_sample/features/album_list/widgets/albums_loading_status.dart';
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
    const initialState = AlbumsLoaded(albums: [], canLoadMore: true);

    setUp(() {
      // Initialize the mock bloc before each test.
      mockBloc = MockAlbumListBloc();
    });

    testWidgets(
      'Initial state displays AlbumsLoadingStatus',
      (WidgetTester tester) async {
        // Stub the bloc state with an empty album list.
        when(() => mockBloc.state).thenReturn(initialState);

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Verify that the AlbumsLoadingStatus is displayed.
        expect(find.byType(AlbumsLoadingStatus), findsOneWidget);
      },
    );

    testWidgets(
      'AlbumsLoaded state displays correct album list with AlbumsLoadingStatus',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
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

        // Stub the bloc state with the AlbumsLoaded state with canLoadMore = true.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            const AlbumsLoaded(albums: albums, canLoadMore: true),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the correct number of AlbumListTile widgets is displayed.
        expect(find.byType(AlbumListTile), findsNWidgets(albums.length));

        // Verify that the AlbumsLoadingStatus is not displayed.
        await expectLater(find.byType(AlbumsLoadingStatus), findsOneWidget);
      },
    );

    testWidgets(
      'AlbumsLoaded state with no more data displays correct album list without AlbumsLoadingStatus',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
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

        // Stub the bloc state with the AlbumsLoaded state with no more data.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            const AlbumsLoaded(albums: albums, canLoadMore: false),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the correct number of AlbumListTile widgets is displayed.
        expect(find.byType(AlbumListTile), findsNWidgets(albums.length));

        // Verify that the AlbumsLoadingStatus is not displayed.
        expect(find.byType(AlbumsLoadingStatus), findsNothing);
      },
    );

    testWidgets(
      'Error state displays AlbumsLoadingStatus widget',
      (WidgetTester tester) async {
        // Stub the bloc state with the AlbumsLoaded state with no more data.
        whenListen(
          mockBloc,
          Stream.fromIterable([const Error()]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the AlbumsLoadingStatus is displayed.
        expect(find.byType(AlbumsLoadingStatus), findsOneWidget);
      },
    );

    testWidgets(
      'Loading state displays AlbumsLoadingStatus widget',
      (WidgetTester tester) async {
        // Stub the bloc state with the AlbumsLoaded state with no more data.
        whenListen(
          mockBloc,
          Stream.fromIterable([const Loading()]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the AlbumsLoadingStatus is displayed.
        expect(find.byType(AlbumsLoadingStatus), findsOneWidget);
      },
    );

    testWidgets(
      'Error state after AlbumsLoaded state adds AlbumsLoadingStatus to the end',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
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

        // Stub the bloc state with the AlbumsLoaded state with canLoadMore = true.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            const AlbumsLoaded(albums: albums, canLoadMore: true),
            const Error(),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the AlbumsLoadingStatus is displayed.
        expect(find.byType(AlbumsLoadingStatus), findsOneWidget);
      },
    );

    testWidgets(
      'Loading state after AlbumsLoaded state adds AlbumsLoadingStatus to the end',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
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

        // Stub the bloc state with the AlbumsLoaded state with canLoadMore = true.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            const AlbumsLoaded(albums: albums, canLoadMore: true),
            const Loading(),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Verify that the AlbumsLoadingStatus is displayed.
        expect(find.byType(AlbumsLoadingStatus), findsOneWidget);
      },
    );

    testWidgets(
      'When canLoadMore is true then scroll down triggers loading more albums',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
        final albums = List.generate(
          10,
          (index) => Album(
            name: 'album$index',
            imageUrl: 'image$index',
            collectionPrice: 9.99,
            currency: 'USD',
          ),
        );

        // Stub the bloc state with the initial AlbumsLoaded state.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            AlbumsLoaded(albums: albums, canLoadMore: true),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Trigger the scroll down event.
        await tester.drag(find.byType(ListView), const Offset(0, -500));

        // Verify LoadAlbumListEvent event has been added to the Bloc.
        verify(() => mockBloc.add(const LoadAlbumListEvent())).called(1);
      },
    );

    testWidgets(
      'When canLoadMore is false then scroll down does not triggers loading more albums',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
        final albums = List.generate(
          10,
          (index) => Album(
            name: 'album$index',
            imageUrl: 'image$index',
            collectionPrice: 9.99,
            currency: 'USD',
          ),
        );

        // Stub the bloc state with the initial AlbumsLoaded state.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            AlbumsLoaded(albums: albums, canLoadMore: false),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Trigger the scroll down event.
        await tester.drag(find.byType(ListView), const Offset(0, -500));

        // Verify LoadAlbumListEvent event has not been added to the Bloc.
        verifyNever(() => mockBloc.add(const LoadAlbumListEvent()));
      },
    );

    testWidgets(
      'When canLoadMore is true but state is Error then scroll down does not triggers loading more albums',
      (WidgetTester tester) async {
        // Prepare a list of albums for the AlbumsLoaded state.
        final albums = List.generate(
          10,
          (index) => Album(
            name: 'album$index',
            imageUrl: 'image$index',
            collectionPrice: 9.99,
            currency: 'USD',
          ),
        );

        // Stub the bloc state with the initial AlbumsLoaded state.
        whenListen(
          mockBloc,
          Stream.fromIterable([
            AlbumsLoaded(albums: albums, canLoadMore: true),
            const Error(),
          ]),
          initialState: initialState,
        );

        // Build our app and trigger a frame.
        await tester.pumpAlbumsListView(mockBloc);

        // Trigger a frame for BlocListener.
        await tester.pump();

        // Trigger the scroll down event.
        await tester.drag(find.byType(ListView), const Offset(0, -500));

        // Verify LoadAlbumListEvent event has not been added to the Bloc.
        verifyNever(() => mockBloc.add(const LoadAlbumListEvent()));
      },
    );
  });
}
