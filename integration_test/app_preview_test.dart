// A scripted tour of the app for the App Store previews (videos).
// tool/store_screenshots/previews.sh runs it on a simulator while recording
// the screen, for each language.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:startup_toolkits/billing/billing_service.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/core/bootstrap.dart';
import 'package:startup_toolkits/core/currency.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/core/theme/theme_providers.dart';
import 'package:startup_toolkits/engines/list_engine.dart';
import 'package:startup_toolkits/features/catalog/catalog_screen.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/l10n/locale_providers.dart';
import 'package:startup_toolkits/main.dart';
import 'package:startup_toolkits/project/project_store.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/tool_def.dart';
import 'package:startup_toolkits/tools/tool_stores.dart';

import '../tool/store_screenshots/terralab.dart';

const lang = String.fromEnvironment('LANG', defaultValue: 'en');

Future<void> wait(double seconds) =>
    Future<void>.delayed(Duration(milliseconds: (seconds * 1000).round()));

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('app preview tour', (tester) async {
    // Black lead-in: the recording is trimmed to the first lit frame.
    await tester.pumpWidget(const ColoredBox(color: Colors.black));
    await wait(4);

    final kv = MemoryKeyValueStore();
    await OnboardingStore(kv).save(true);
    await LocaleStore(kv).save(const Locale(lang));
    await ThemeModeStore(kv).save(ThemeMode.dark);
    await ProjectStore(kv).save(terralab(lang));

    // Match currency symbol with the preview's language.
    final currency = switch (lang) {
      'tr' => 'TRY',
      'de' || 'fr' || 'es' => 'EUR',
      _ => 'USD',
    };
    await CurrencyStore(kv).save(currency);

    // Seed the investor tracker with localized samples so it doesn't show empty.
    final catalog = ToolCatalog.of(lang, Sector.rnd);
    final investorTool = catalog.byId('investorTracker');
    if (investorTool != null) {
      await ListStore(kv).save('investorTracker', [
        for (var i = 0; i < investorTool.samples.length; i++)
          ListItem(
            id: 'sample-$i',
            title: investorTool.samples[i].title,
            stage: investorTool.samples[i].stage,
            fields: investorTool.samples[i].fields,
          ),
      ]);
    }

    await tester.pumpWidget(
      AppRoot(
        kv: kv,
        overrides: await loadAppState(kv, DateTime.now()),
        services: [billingServiceProvider.overrideWithValue(_PreviewStore())],
      ),
    );

    final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
    Future<void> open(Widget page) async {
      nav.push(MaterialPageRoute<void>(builder: (_) => page)).ignore();
      await wait(1.2);
    }

    Future<void> back() async {
      nav.pop();
      await wait(0.8);
    }

    // Programmatic smooth scroll: avoids the test pointer crosshair overlay.
    Future<void> scroll(double dy, double seconds) async {
      final scrollables = find.byType(Scrollable).hitTestable();
      if (scrollables.evaluate().isEmpty) return;
      final state = tester.state<ScrollableState>(scrollables.first);
      final position = state.position;
      await position.animateTo(
        (position.pixels - dy).clamp(
          position.minScrollExtent,
          position.maxScrollExtent,
        ),
        duration: Duration(milliseconds: (seconds * 1000).round()),
        curve: Curves.easeInOutCubic,
      );
    }

    // Programmatic slider drag: moves the value smoothly without touch markers.
    Future<void> animateSlider(double targetValue, double seconds) async {
      final sliderFinder = find.byType(Slider);
      if (sliderFinder.evaluate().isEmpty) return;
      final slider = tester.widget<Slider>(sliderFinder.first);
      final start = slider.value;
      final steps = (seconds * 30).round().clamp(10, 60);
      for (var i = 1; i <= steps; i++) {
        final t = i / steps;
        final eased = t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t;
        final current = start + (targetValue - start) * eased;
        tester.widget<Slider>(sliderFinder.first).onChanged?.call(current);
        await tester.pump();
        await wait(seconds / steps);
      }
    }

    Future<void> selectTab(int index) async {
      final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      bar.onDestinationSelected?.call(index);
      await tester.pump();
    }

    // 1. Home: mission control, then explore suggested tools.
    await wait(2.5);
    await scroll(-260, 1.4);
    await wait(1);

    // 2. Pitch deck written from the project.
    await open(const ToolScreen(toolId: 'pitchDeck'));
    await wait(1);
    await scroll(-700, 2.4);
    await wait(0.8);
    await back();

    // 3. Runway: smoothly move the cash slider and watch the ring follow.
    await open(const ToolScreen(toolId: 'runway'));
    await wait(1.0);
    await animateSlider(540000, 1.0);
    await wait(0.4);
    await animateSlider(390000, 1.0);
    await wait(1.0);
    await back();

    // 4. Investor pipeline.
    await open(const ToolScreen(toolId: 'investorTracker'));
    await wait(2.2);
    await back();

    // 5. The project that fills every tool.
    await selectTab(1);
    await wait(1.5);
    await scroll(-400, 1.6);
    await wait(0.8);
    await selectTab(0);
    await wait(0.6);

    // 6. All 45 tools catalog.
    await open(const CatalogScreen());
    await scroll(-1400, 3.0);
    await wait(1.5);
  });
}

/// Launch prices without the preview-store note.
class _PreviewStore extends PreviewBillingService {
  @override
  bool get isPreview => false;
}

