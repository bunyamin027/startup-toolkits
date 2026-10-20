import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/billing_config.dart';
import 'package:startup_toolkits/core/app_info.dart';
import 'package:startup_toolkits/features/profile/profile_screen.dart';

import 'helpers.dart';

void main() {
  test('AppInfo.version matches pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(
      r'^version: ([\d.]+)\+',
      multiLine: true,
    ).firstMatch(pubspec)![1];
    expect(AppInfo.version, version);
  });

  test('legal links are set for store review', () {
    expect(
      BillingConfig.termsUrl,
      'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/',
    );
    expect(BillingConfig.privacyUrl, 'https://www.kahramanapp.com/privacy');
  });

  testWidgets('Profile lists legal links, support and developer', (
    tester,
  ) async {
    await pumpApp(tester, const Scaffold(body: ProfileScreen()));
    await tester.scrollUntilVisible(find.text('Kahramanapp'), 200);
    expect(find.text('Terms of Use (EULA)'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Support & feedback'), findsOneWidget);
    expect(find.text('kahramandev01@gmail.com'), findsOneWidget);
    expect(find.text('Developer'), findsOneWidget);
  });
}
