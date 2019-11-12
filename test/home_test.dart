// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cest_pret_de_chez_vous/src/display_ads/view/home.dart';

void main() {

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('Favorite widget test', (WidgetTester tester) async {
    Home page = Home();
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // test scrollable content in home widget (Card's printed)
    final getsure = await tester.startGesture(Offset.zero);
    await getsure.moveBy(const Offset(0, 100));
    await tester.pump();

    // verify if myWidget is returned
    expect(find.byWidget(page), findsOneWidget);
  });
}
