// Captures the raw app screens for the App Store screenshots, on macOS:
//
//   flutter test tool/store_screenshots/capture_test.dart \
//     --dart-define=OUT=/tmp/shots/raw [--dart-define=DEVICE=ipad|duo]
//   python3 -I tool/store_screenshots/compose.py /tmp/shots/raw \
//     docs/store/screenshots/iphone-6.9
//
// Not part of the test suite: it lives outside test/ and needs the system
// SF font. Screens render with the real app code, in each language.
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/features/catalog/catalog_screen.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';

import 'shot_app.dart';

const out = String.fromEnvironment('OUT');

/// `--dart-define=DEVICE=ipad` for the 13" iPad (2064 x 2752), `duo` for
/// iPhone Duo unfolded (1398 x 2034); iPhone 6.9" (1320 x 2868) otherwise.
const device = String.fromEnvironment('DEVICE');
final physical = switch (device) {
  'ipad' => const Size(2064, 2752),
  'duo' => const Size(1398, 2034),
  _ => const Size(1320, 2868),
};
const ratio = device == 'ipad' ? 2.0 : 3.0;
final inset = switch (device) {
  'ipad' => const FakeViewPadding(top: 24 * 2, bottom: 20 * 2),
  'duo' => const FakeViewPadding(top: 32 * 3, bottom: 20 * 3),
  _ => const FakeViewPadding(top: 62 * 3, bottom: 34 * 3),
};
const langs = ['en', 'tr', 'fr', 'es', 'de'];

Future<void> push(WidgetTester tester, Widget page) async {
  final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
  unawaited(nav.push(MaterialPageRoute<void>(builder: (_) => page)));
  await tester.pumpAndSettle();
}

Future<void> save(WidgetTester tester, String name) async {
  final view = tester.binding.renderViews.first;
  final image = await tester.runAsync(
    () => (view.debugLayer! as OffsetLayer).toImage(
      Offset.zero & physical,
      pixelRatio: 1,
    ),
  );
  final bytes = await tester.runAsync(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  File('$out/$name.png')
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes!.buffer.asUint8List());
}

void main() {
  final shots = <String, (bool, Future<void> Function(WidgetTester))>{
    '01_home': (true, (t) async {}),
    '02_pitchDeck': (
      false,
      (t) => push(t, const ToolScreen(toolId: 'pitchDeck')),
    ),
    '03_runway': (true, (t) => push(t, const ToolScreen(toolId: 'runway'))),
    '04_investorTracker': (
      false,
      (t) => push(t, const ToolScreen(toolId: 'investorTracker')),
    ),
    '05_project': (
      true,
      (t) async {
        await t.tap(find.byType(NavigationDestination).at(1));
        await t.pumpAndSettle();
      },
    ),
    '06_leanCanvas': (
      false,
      (t) => push(t, const ToolScreen(toolId: 'leanCanvas')),
    ),
    '07_capTable': (
      false,
      (t) => push(t, const ToolScreen(toolId: 'capTable')),
    ),
    '08_nda': (false, (t) => push(t, const ToolScreen(toolId: 'nda'))),
    '09_catalog': (false, (t) => push(t, const CatalogScreen())),
    '10_unitEconomics': (
      false,
      (t) => push(t, const ToolScreen(toolId: 'unitEconomics')),
    ),
  };

  for (final lang in langs) {
    for (final MapEntry(key: name, value: (withProject, action))
        in shots.entries) {
      testWidgets('$lang $name', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        await tester.runAsync(loadFonts);
        tester.view.physicalSize = physical;
        tester.view.devicePixelRatio = ratio;
        tester.view.padding = inset;
        tester.view.viewPadding = inset;
        tester.platformDispatcher.accessibilityFeaturesTestValue =
            const FakeAccessibilityFeatures(disableAnimations: true);
        addTearDown(tester.view.reset);
        addTearDown(
          tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
        );
        await pumpAppState(tester, lang, withProject: withProject);
        await action(tester);
        await save(tester, '$lang/$name');
        debugDefaultTargetPlatformOverride = null;
      });
    }
  }
}
