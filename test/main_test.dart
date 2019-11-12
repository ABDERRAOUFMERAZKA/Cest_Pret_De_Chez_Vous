// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cest_pret_de_chez_vous/main.dart';

void main() {

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('Favorite widget test', (WidgetTester tester) async {
    MyApp page = MyApp();
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // verify if myWidget is returned
    expect(find.byWidget(page), findsOneWidget);
  });
}
