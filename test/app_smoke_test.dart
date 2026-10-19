import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/theme/app_tokens.dart';
import 'package:startup_toolkits/main.dart';

void main() {
  testWidgets('app starts on the dark theme with tokens available', (
    tester,
  ) async {
    await tester.pumpWidget(const StartupToolkitsApp());
    expect(find.text('Startup Toolkits'), findsOneWidget);

    final context = tester.element(find.byType(Scaffold));
    expect(context.tokens.bg, AppTokens.dark.bg);
    expect(Theme.of(context).brightness, Brightness.dark);
  });
}
