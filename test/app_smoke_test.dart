import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/theme/app_tokens.dart';
import 'package:startup_toolkits/features/catalog/catalog_screen.dart';

import 'helpers.dart';

void main() {
  testWidgets('catalog lists tools and opens one', (tester) async {
    await pumpApp(tester, const CatalogScreen());
    expect(find.text('45 tools for founders'), findsOneWidget);

    final context = tester.element(find.byType(CatalogScreen));
    expect(context.tokens.bg, AppTokens.dark.bg);

    await tester.enterText(find.byType(TextField), 'runway');
    await tester.pumpAndSettle();
    expect(find.text('Runway & burn rate'), findsOneWidget);
    expect(find.text('SWOT analysis'), findsNothing);

    await tester.tap(find.text('Runway & burn rate'));
    await tester.pumpAndSettle();
    expect(find.text('11.4 months'), findsOneWidget);
  });
}
