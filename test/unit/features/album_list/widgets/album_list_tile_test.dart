import 'package:albums_sample/features/album_list/models/album.dart';
import 'package:albums_sample/features/album_list/widgets/album_list_tile.dart';
import 'package:albums_sample/features/album_list/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AlbumListTile displays correctly', (WidgetTester tester) async {
    const album = Album(
      name: 'album',
      imageUrl: 'imageUrl',
      collectionPrice: 1.22,
      currency: 'USD',
    );

    await tester.pumpWidget(
      const MaterialApp(home: Material(child: AlbumListTile(album: album))),
    );

    // Verify that the album image is displayed.
    expect(find.byType(Image), findsOneWidget);
    expect(
      find.byWidgetPredicate(
          (widget) => widget is Image && widget.width == 56.0),
      findsOneWidget,
    );

    expect(find.text(album.name), findsOneWidget);

    // Verify that the album price is displayed.
    expect(find.text('${album.collectionPrice} ${album.currency}'),
        findsOneWidget);

    // Verify that the LikeButton is displayed.
    expect(find.byType(LikeButton), findsOneWidget);
  });

  testWidgets('AlbumListTile displays with no price',
      (WidgetTester tester) async {
    // Prepare the data for the album with no price.
    const album = Album(
      name: 'name',
      imageUrl: 'imageUrl',
      currency: '',
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(home: Material(child: AlbumListTile(album: album))),
    );

    // Verify that the album price is not displayed.
    expect(
        find.text('${album.collectionPrice} ${album.currency}'), findsNothing);
  });
}
