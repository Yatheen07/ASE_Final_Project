// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ase_group5_scm/Routes/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ase_group5_scm/Routes/dublin_bikes_map.dart';
import 'package:ase_group5_scm/main.dart';

void main() {
  Widget testLoginWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: loginScreen()),
  );
  Widget testMapsWidget = new MediaQuery(
    data: new MediaQueryData(),
    child: new MaterialApp(home: BikeStationMap()),
  );
  testWidgets("username field validation", (WidgetTester tester) async {
    await tester.pumpWidget(testLoginWidget);
    await tester.pump();
    expect(find.byKey(Key("username-field")), findsOneWidget);
  });
  testWidgets("password field validation", (WidgetTester tester) async {
    await tester.pumpWidget(testLoginWidget);
    await tester.pump();
    expect(find.byKey(Key("password-field")), findsOneWidget);
  });
  testWidgets("sign In widget validation", (WidgetTester tester) async {
    await tester.pumpWidget(testLoginWidget);
    expect(find.text("Login"), findsOneWidget);
  });
  testWidgets("Google Maps validation", (WidgetTester tester) async {
    await tester.pumpWidget(testLoginWidget);
    //firebase is not initialized therefore no google maps widget is expected
    expect(find.byKey(Key("dublin-bikes-map")), findsNothing);
  });


}
