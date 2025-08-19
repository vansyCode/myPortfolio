import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';

void main() {
  testWidgets('App shows Irvan Sinado on home screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    // Cek apakah nama kamu muncul di layar
    expect(find.text('Irvan Sinado'), findsWidgets);
  });
}
