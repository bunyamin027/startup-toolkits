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
  --dart-define=RC_GOOGLE_KEY=goog_xxx
```

- RevenueCat setup: entitlement `pro`; a current offering with a monthly
  and an annual package; a 2-week free trial as the introductory offer.
- Without a key, debug builds use a **preview store** (placeholder prices,
  fake purchases, labelled on the paywall); release builds disable
  purchases and the paywall says subscriptions are unavailable.
- Legal links default to Apple's standard EULA and
  https://www.kahramanapp.com/privacy (override with `TERMS_URL` /
  `PRIVACY_URL`). Support mail and developer name live in
  `lib/core/app_info.dart`.
- First iOS build after adding RevenueCat may need
  `cd ios && pod install --repo-update`.

## Languages

Everything the user reads ships in English, Turkish, French, Spanish and
German, and switches at once when the language changes (no restart):

- UI strings: `lib/l10n/app_{en,tr,fr,es,de}.arb`, read with `context.l10n`.
- Tool content (names, labels, examples, templates, stages, sample rows,
  calculator outputs and verdicts): `lib/tools/l10n/<category>_text.dart`,
  one file per catalog category. Screens read tools through
  `context.tools`; providers through `appLocaleProvider`.
- Numbers: `Fmt.of(language)` (grouping, decimals, `$` placement, month
  words). Typed numbers accept both `1,234.5` and `1.234,5`.

The app follows the system language; Profile → Language overrides it
(stored under `locale.v1`, kept on "Delete all data").

What stays English on purpose, so saved data survives a language change:
stage names and choice values stored in items and inputs (they are shown
translated), and the field labels the project mapper matches on
(`FieldDef.mappingLabel`). Saved inputs that still equal an example in any
language, and sample rows the user has not edited, follow the new language;
anything the user typed stays as typed.

To add a language (the plan also lists pt and ar):

1. Copy `app_en.arb` to `app_<code>.arb` and translate the values.
2. Add a `'<code>'` entry to every `lib/tools/l10n/*_text.dart` map and to
   `calcTexts`, `DocEngine._legalNotices` and `Fmt._months`.
3. Add the code to `toolLanguages` (`catalog.dart`), `languageNames`
   (`locale_providers.dart`) and `CFBundleLocalizations` (`Info.plist`).
4. Run `flutter gen-l10n` and the tests. `test/tool_text_test.dart` fails on
   any untranslated tool text or a template whose placeholders differ from
   English; `test/l10n_test.dart` renders every screen and tool in each
   language on an iPhone SE, so overflows from long translations fail too.
5. Layouts already use start/end (directional) padding and alignment, and
   `test/rtl_test.dart` renders every screen and tool right to left, so
   Arabic needs translations only.

Legal templates are plain translations, not jurisdiction-checked texts;
every language appends the "not legal advice" notice in that language.

## Analytics

Decision for v1: **no analytics backend**. Nothing leaves the device apart
from purchases through RevenueCat, which keeps the App Privacy answers in
`docs/store/privacy-labels.md` and the privacy policy simple.
`lib/core/analytics.dart` still defines the funnel events from the plan;
they are printed in debug builds and dropped in release. Adding PostHog or
Firebase later means one `Analytics` implementation plus updated privacy
labels and policy.

## Layout

```text
lib/
  core/       theme tokens (theme/), number formatting, key-value storage
  engines/    CalcEngine (8 formulas), DocEngine (templates + {=expr}), ListEngine
  core/widgets/  AppCard, RiseIn, CountUp, RingGauge (respect Reduce Motion)
  tools/      ToolDef / FieldDef, catalog/ (45 tools, English), l10n/ (their
              translations), providers, stores
  core/bootstrap.dart  loads all state before the first frame; delete all data
  project/    Project (13 fields), FieldMapper, launch_path (Home steps), store
  billing/    Entitlement (trial, one tool per day, subscriber), providers
  features/   onboarding, shell (tabs), home, project, favorites (My tools),
              profile, catalog (Discover/search), tool (one screen, 45 tools)
  l10n/       app_*.arb (5 languages), generated AppLocalizations, context.l10n,
              language picker state
```

## Decisions (plan §14)

| # | Decision | Outcome | Where |
| --- | --- | --- | --- |
| 1 | App name | **Startup Toolkits**, icon in place | Info.plist, AndroidManifest |
| 2 | Prices | **$6.99 / month, $49.99 / year** (yearly saves 40%), 14-day intro offer; local tiers come from the stores | App Store Connect / Play Console, `docs/store/app-store-listing.md`; preview store in `lib/billing/billing_service.dart` |
| 3 | Trial type | In-app 14-day trial from first launch, as in the prototype (confirmed). The paywall also offers the store's intro trial when the user is eligible (its button text comes from the store). Switching to store-only means setting `Entitlement.trialLength` to zero | `lib/billing/entitlement.dart`, `lib/features/paywall/` |
| 4 | Free plan | One tool per day, resets at local midnight (confirmed) | `lib/billing/entitlement.dart` |
| 5 | Light theme | Designed (`AppTokens.light`); Profile → Appearance picks System / Dark / Light, default System. Every text color passes WCAG AA in both themes (`test/theme_test.dart`). Launch screens stay dark as a brand splash | `lib/core/theme/`, `lib/main.dart` |
| 6 | Platforms | iOS and Android together (cross-platform) | project setup |
| — | Analytics | None in v1 (see Analytics) | `lib/core/analytics.dart` |

Other choices:

- Bundle id: `com.startuptoolkits.startup_toolkits` (placeholder).
- Tracker items are stored in shared_preferences as JSON (`ListStore`), not Hive/Isar; the store can be swapped without touching callers.
- Tool texts live in Dart maps (`lib/tools/l10n/`), not .arb files: the
  templates use `{placeholders}` that clash with ICU syntax.
- Example data uses a fictional startup, Nimbly (bookkeeping for freelancers).

## Known issue: building from an iCloud-synced folder

If Desktop is synced with iCloud Drive, iOS builds fail with
"resource fork, Finder information, or similar detritus not allowed".
Move the project to a folder outside iCloud (for example `~/Developer`).
