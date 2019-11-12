// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cest_pret_de_chez_vous/src/display_ads/view/favorites.dart';

void main() {

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('Favorite widget test', (WidgetTester tester) async {
    Favorite page = Favorite();
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // verify if myWidget is returned
    expect(find.byWidget(page), findsOneWidget);

    // check if test text not display in the widget
    expect(find.text('test text'), findsNothing);

    // check if My Ad Screen display in the widget
    expect(find.text('Favorite Screen'), findsOneWidget);
  });
}
