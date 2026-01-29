import 'dart:convert';
import 'dart:typed_data';

import 'package:dishdash/features/trending_recipes/presentation/leave_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _OnePixelAssetBundle extends CachingAssetBundle {
  static final Uint8List _pngBytes = base64Decode(
    // 1x1 transparent PNG
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB/ax0f3cAAAAASUVORK5CYII=',
  );

  @override
  Future<ByteData> load(String key) async {
    return ByteData.view(_pngBytes.buffer);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return '';
  }
}

void main() {
  testWidgets('Submit disabled until review text entered', (tester) async {
    await tester.pumpWidget(
      DefaultAssetBundle(
        bundle: _OnePixelAssetBundle(),
        child: MaterialApp(
          home: LeaveReviewPage(
            recipeTitle: 'Test Recipe',
            recipeImage: 'lib/core/assets/logo_splash.png',
          ),
        ),
      ),
    );

    // Tap submit with empty text: should not open the thank-you dialog.
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Thank You For\nYour Review!'), findsNothing);

    // Enter review text: submit should become enabled.
    await tester.enterText(find.byType(TextField), 'Great recipe!');
    await tester.pump();

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Thank You For\nYour Review!'), findsOneWidget);

    // Close dialog via Go To Home.
    await tester.tap(find.text('Go To Home'));
    await tester.pumpAndSettle();

    expect(find.text('Thank You For\nYour Review!'), findsNothing);
  });
}
