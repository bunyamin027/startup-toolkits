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

## Layout

```
lib/
  core/       theme tokens (theme/), number formatting, key-value storage
  engines/    CalcEngine (8 formulas), DocEngine (templates + {=expr}), ListEngine
  tools/      ToolDef / FieldDef, favorites and tracker storage
  project/    Project (13 fields), FieldMapper (auto-fill), ProjectStore
  billing/    Entitlement (trial, one tool per day, subscriber) and its store
  features/   screens (Sprint 2–3)
  l10n/       .arb files (with localization work)
```

## Defaults taken for open decisions (plan §14)

| # | Decision | Default used | Where |
|---|---|---|---|
| 1 | App name | **Startup Toolkits** (given). Icon still open | Info.plist, AndroidManifest |
| 3 | Trial type | In-app 14-day trial from first launch, as in the prototype. Switching to a store trial means setting `Entitlement.trialLength` to zero | `lib/billing/entitlement.dart` |
| 4 | Free plan | One tool per day, resets at local midnight | `lib/billing/entitlement.dart` |
| 5 | Light theme | Placeholder values under the same token names; app is forced to dark | `lib/core/theme/app_tokens.dart`, `lib/main.dart` |
| 6 | Platforms | iOS and Android together (cross-platform) | project setup |

Other choices:
- Bundle id: `com.startuptoolkits.startup_toolkits` (placeholder).
- Tracker items are stored in shared_preferences as JSON (`ListStore`), not Hive/Isar; the store can be swapped without touching callers.
- Number formatting is en-US until localization lands.
