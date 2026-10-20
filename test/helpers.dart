import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/core/storage/storage_providers.dart';
import 'package:startup_toolkits/core/bootstrap.dart';
import 'package:startup_toolkits/core/theme/app_theme.dart';
import 'package:startup_toolkits/main.dart';
import 'package:startup_toolkits/l10n/l10n.dart';

/// Logical screen sizes (points).
const iPhone15 = Size(393, 852);
const iPhoneSE = Size(375, 667);

/// Sets the test view to [screen] at 3× and the system text size to
/// [textScale] (Dynamic Type), resetting both after the test.
void setScreen(WidgetTester tester, Size screen, double textScale) {
  tester.view.devicePixelRatio = 3;
  tester.view.physicalSize = screen * 3;
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

/// Pumps [home] inside the app theme with in-memory storage, on an
/// iPhone-sized screen. Returns the container for reading providers.
Future<ProviderContainer> pumpApp(
  WidgetTester tester,
  Widget home, {
  KeyValueStore? kv,
  List<dynamic> overrides = const [],
  Size screen = iPhone15,
  double textScale = 1,
  TextDirection? direction,
}) async {
  setScreen(tester, screen, textScale);

  final container = ProviderContainer.test(
    overrides: [
      keyValueStoreProvider.overrideWithValue(kv ?? MemoryKeyValueStore()),
      ...overrides.cast(),
    ],
  );
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: home,
        // Tests run with Reduce Motion so endless pulses let pumpAndSettle
        // finish and numbers show their final value at once.        // [direction] forces RTL before an RTL language ships.
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: Directionality(
            textDirection: direction ?? Directionality.of(context),
            child: child!,
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

/// Full app on an iPhone-sized screen with Reduce Motion on (endless pulses
/// would keep pumpAndSettle from finishing).
Future<MemoryKeyValueStore> pumpRoot(
  WidgetTester tester, {
  MemoryKeyValueStore? kv,
  List<Override> services = const [],
  Size screen = iPhone15,
  double textScale = 1,
}) async {
  setScreen(tester, screen, textScale);
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

  final store = kv ?? MemoryKeyValueStore();
  final overrides = await loadAppState(store, DateTime.now());
  await tester.pumpWidget(
    AppRoot(kv: store, overrides: overrides, services: services),
  );
  await tester.pumpAndSettle();
  return store;
}

Future<void> onboard(WidgetTester tester, {String name = 'Rocketly'}) async {
  await tester.tap(find.text('Raise funding'));
  await tester.pump();
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
  await tester.enterText(find.widgetWithText(TextField, 'Startup name'), name);
  await tester.enterText(
    find.widgetWithText(TextField, 'One-line description'),
    'Fundraising copilot for first-time founders',
  );
  await tester.pump();
  await tester.tap(find.text('Start building'));
  await tester.pumpAndSettle();
}

/// Scrolls the visible tab's list until [finder] is built, then a bit
/// more so it clears the bottom tab bar.
Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  final list = find.byType(ListView).hitTestable().first;
  await tester.scrollUntilVisible(
    finder,
    300,
    scrollable: find
        .descendant(of: list, matching: find.byType(Scrollable))
        .first,
  );
  await tester.drag(list, const Offset(0, -200));
  await tester.pumpAndSettle();
}

/// Storage override for plain [ProviderContainer] tests.
Future<List<Override>> keyValueOverride([KeyValueStore? kv]) async => [
  keyValueStoreProvider.overrideWithValue(kv ?? MemoryKeyValueStore()),
];
