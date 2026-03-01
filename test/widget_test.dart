// Basic Flutter widget test for WiseCareApp.

import 'package:flutter_test/flutter_test.dart';

import 'package:wisecare_frontend/main.dart';

void main() {
  testWidgets('App builds and shows WiseCare', (WidgetTester tester) async {
    await tester.pumpWidget(const WiseCareApp());
    await tester.pumpAndSettle();
    expect(find.text('WiseCare'), findsOneWidget);
  });
}
