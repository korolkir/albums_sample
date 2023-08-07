import 'package:albums_sample/features/album_list/widgets/album_list_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Verify AlbumListLoadingWidget content',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: AlbumListLoadingWidget()),
      );

      // Verify that the padding widget is displayed.
      expect(find.byType(Padding), findsOneWidget);

      // Verify that the center widget is displayed.
      expect(find.byType(Center), findsOneWidget);

      // Verify that the CircularProgressIndicator is displayed.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
