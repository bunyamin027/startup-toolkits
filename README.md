# Startup Toolkits

Mini tools for founders in one Flutter app (iOS + Android).
The single source of truth for product, design and roadmap is
[Startup-Cebimde-Master-Plan.md](Startup-Cebimde-Master-Plan.md).

## Run

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

## Release

- `docs/release/checklist.md`: what is done, what needs accounts or
  decisions, build commands and the internal test script.
- `docs/store/`: listing text, privacy labels, screenshots.
- `docs/legal/`: privacy policy and terms drafts (placeholders marked).
- App icon: edit and run `python3 -I tool/icon/generate_icon.py`.

## Subscriptions and legal links

Keys and URLs are passed at build time, never committed:

```sh
flutter run \
  --dart-define=RC_APPLE_KEY=appl_xxx \
  --dart-define=RC_GOOGLE_KEY=goog_xxx \
  --dart-define=TERMS_URL=https://example.com/terms \
  --dart-define=PRIVACY_URL=https://example.com/privacy
```

- RevenueCat setup: entitlement `pro`; a current offering with a monthly
  and an annual package; a 2-week free trial as the introductory offer.
- Without a key, debug builds use a **preview store** (placeholder prices,
  fake purchases, labelled on the paywall); release builds disable
  purchases and the paywall says subscriptions are unavailable.
- Missing Terms/Privacy URLs show "This link is added before release".
- First iOS build after adding RevenueCat may need
  `cd ios && pod install --repo-update`.

## Languages

UI strings live in `lib/l10n/app_en.arb` and are read with `context.l10n`.
To add a language (the plan lists es, pt, tr, ar):

1. Copy `app_en.arb` to `app_<code>.arb` and translate the values.
2. Run `flutter gen-l10n` (or any build); the locale is picked up
   automatically.
3. Layouts already use start/end (directional) padding and alignment, and
   `test/rtl_test.dart` renders every screen and tool right to left, so
   Arabic needs translations only.

Still English-only: tool content in `lib/tools/catalog/` (names,
templates, calculator labels) and number formatting in `Fmt` (en-US).
Both move with the first new language.

## Analytics

`lib/core/analytics.dart` defines the funnel events from the plan. Until a
backend (Firebase or PostHog) is picked, events are printed in debug builds
and dropped in release; nothing leaves the device.

## Layout

```text
lib/
  core/       theme tokens (theme/), number formatting, key-value storage
  engines/    CalcEngine (8 formulas), DocEngine (templates + {=expr}), ListEngine
  core/widgets/  AppCard, RiseIn, CountUp, RingGauge (respect Reduce Motion)
  tools/      ToolDef / FieldDef, catalog/ (45 tools), providers, stores
  core/bootstrap.dart  loads all state before the first frame; delete all data
  project/    Project (13 fields), FieldMapper, launch_path (Home steps), store
  billing/    Entitlement (trial, one tool per day, subscriber), providers
  features/   onboarding, shell (tabs), home, project, favorites (My tools),
              profile, catalog (Discover/search), tool (one screen, 45 tools)
  l10n/       app_en.arb, generated AppLocalizations, context.l10n helpers
```

## Defaults taken for open decisions (plan §14)

| # | Decision | Default used | Where |
| --- | --- | --- | --- |
| 1 | App name | **Startup Toolkits** (given). Icon still open | Info.plist, AndroidManifest |
| 3 | Trial type | In-app 14-day trial from first launch, as in the prototype. The paywall also offers the store's intro trial when the user is eligible (its button text comes from the store). Switching to store-only means setting `Entitlement.trialLength` to zero | `lib/billing/entitlement.dart`, `lib/features/paywall/` |
| 4 | Free plan | One tool per day, resets at local midnight | `lib/billing/entitlement.dart` |
| 5 | Light theme | Placeholder values under the same token names; app is forced to dark | `lib/core/theme/app_tokens.dart`, `lib/main.dart` |
| 6 | Platforms | iOS and Android together (cross-platform) | project setup |

Other choices:

- Bundle id: `com.startuptoolkits.startup_toolkits` (placeholder).
- Tracker items are stored in shared_preferences as JSON (`ListStore`), not Hive/Isar; the store can be swapped without touching callers.
- Number formatting is en-US until localization lands.
- Tool texts (names, labels, templates) live in the catalog in English; they
  move to .arb files with localization.
- Example data uses a fictional startup, Nimbly (bookkeeping for freelancers).

## Known issue: building from an iCloud-synced folder

If Desktop is synced with iCloud Drive, iOS builds fail with
"resource fork, Finder information, or similar detritus not allowed".
Move the project to a folder outside iCloud (for example `~/Developer`).
