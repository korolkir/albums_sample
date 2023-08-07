import 'package:albums_sample/features/album_list/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LikeButton displays correct icon when not liked',
      (WidgetTester tester) async {
    // Build our app and trigger a frame with not liked state.
    await tester.pumpWidget(
      const MaterialApp(home: Material(child: LikeButton(isLiked: false))),
    );

    // Verify that the correct icon is displayed.
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

  testWidgets('LikeButton displays correct icon when liked',
      (WidgetTester tester) async {
    // Build our app and trigger a frame with liked state.
    await tester.pumpWidget(
      const MaterialApp(home: Material(child: LikeButton(isLiked: true))),
    );

    // Verify that the correct icon is displayed.
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });

  testWidgets('LikeButton onPressed callback is triggered',
      (WidgetTester tester) async {
    bool isButtonPressed = false;

    // Define the callback function.
    void onPressedCallback() {
      isButtonPressed = true;
    }

    // Build our app and trigger a frame with the callback function.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
            child: LikeButton(isLiked: false, onPressed: onPressedCallback)),
      ),
    );

    // Tap the LikeButton to trigger the callback.
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    // Verify that the onPressed callback was triggered and the liked state is updated.
    expect(isButtonPressed, isTrue);
  });
}
