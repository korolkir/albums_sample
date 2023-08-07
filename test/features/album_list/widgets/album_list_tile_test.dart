import 'package:albums_sample/features/album_list/blocs/album_list_bloc.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_event.dart';
import 'package:albums_sample/features/album_list/blocs/album_list_state.dart';
import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_tile.dart';
import 'package:albums_sample/features/album_list/widgets/album_like_button.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAlbumListBloc extends MockBloc<AlbumListEvent, AlbumListState>
    implements AlbumListBloc {}

extension on WidgetTester {
  Future<void> pumpAlbumListTileWidget({
    required Album album,
    required int index,
    required bool isFavorite,
    AlbumListBloc? bloc,
  }) {
    final tile = Material(
      child: AlbumListTile(
        album: album,
        index: index,
        isFavorite: isFavorite,
      ),
    );
    return pumpWidget(
      MaterialApp(
        home: bloc == null
            ? tile
            : BlocProvider.value(
                value: bloc,
                child: tile,
              ),
      ),
    );
  }
}

void main() {
  group(
    'AlbumListTile Tests',
    () {
      const album = Album(
        name: 'album',
        imageUrl: 'imageUrl',
        collectionPrice: 1.22,
        currency: 'USD',
      );
      const index = 5;

      testWidgets(
        'Verify AlbumListTile common content',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.
          await tester.pumpAlbumListTileWidget(
            album: album,
            index: index,
            isFavorite: true,
          );

          // Verify that the album image is displayed.
          expect(
            find.byWidgetPredicate(
                (widget) => widget is Image && widget.width == 56.0),
            findsOneWidget,
          );

          // Verify the album name is displayed.
          expect(find.text(album.name), findsOneWidget);

          // Verify that the album price is displayed.
          expect(find.text('${album.collectionPrice} ${album.currency}'),
              findsOneWidget);

          // Verify that the LikeButton is displayed.
          expect(find.byType(AlbumLikeButton), findsOneWidget);
        },
      );

      testWidgets(
        'When collectionPrice is not provided '
        'Then subtitle is not displayed',
        (WidgetTester tester) async {
          // Prepare the data for the album with no price.
          const album = Album(
            name: 'name',
            imageUrl: 'imageUrl',
            currency: '',
          );

          // Build our app and trigger a frame.
          await tester.pumpAlbumListTileWidget(
            album: album,
            index: index,
            isFavorite: true,
          );
          // Verify that the album price is not displayed.
          expect(find.text('${album.collectionPrice} ${album.currency}'),
              findsNothing);
        },
      );

      testWidgets(
        'When isFavorite = true '
        'Then display LikeButton with isLiked = true',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.
          await tester.pumpAlbumListTileWidget(
            album: album,
            index: index,
            isFavorite: true,
          );

          // Verify that the LikeButton is displayed with isLiked = true.
          expect(
            find.byWidgetPredicate(
              (widget) => widget is AlbumLikeButton && widget.isLiked == true,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'When isFavorite = false '
        'Then display LikeButton with isLiked = false',
        (WidgetTester tester) async {
          // Build our app and trigger a frame.
          await tester.pumpAlbumListTileWidget(
            album: album,
            index: index,
            isFavorite: false,
          );

          // Verify that the LikeButton is displayed with isLiked = false.
          expect(
            find.byWidgetPredicate(
              (widget) => widget is AlbumLikeButton && widget.isLiked == false,
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'When like button is clicked '
        'Then add ToggleFavoriteAlbumEvent to albums bloc',
        (WidgetTester tester) async {
          // Create mock block
          final albumsBloc = MockAlbumListBloc();

          // Build our app and trigger a frame.
          await tester.pumpAlbumListTileWidget(
            album: album,
            index: index,
            isFavorite: false,
            bloc: albumsBloc,
          );

          // Perform click on LikeButton
          await tester.tap(find.byType(AlbumLikeButton));

          // Verify that the LoadAlbumListEvent is added.
          verify(
            () => albumsBloc.add(const ToggleFavoriteAlbumEvent(index: index)),
          ).called(1);
        },
      );
    },
  );
}
