# Startup Toolkit

Mini tools for founders in one Flutter app (iOS + Android).  
Everything a solo founder, indie hacker, or early-stage team needs to plan, validate, fundraise, and launch.

The single source of truth for product, design and roadmap is [Startup-Cebimde-Master-Plan.md](Startup-Cebimde-Master-Plan.md).

---

## Features

- **45 Founder Tools in One Place:**
  - **Strategy & Validation:** Lean Canvas, Value Proposition, Idea Scoring, Competitor Matrix, Persona Builder.
  - **Financial Models & Calculators:** Runway & Burn Rate, Unit Economics (LTV/CAC), Pricing Calculator, Cap Table Simulator, Valuation Estimate.
  - **Fundraising & Pitching:** Pitch Deck Wizard, One-Pager Generator, Investor CRM / Tracker, Safe Note Generator.
  - **Legal & Operations:** Mutual NDA, Advisory Agreement, IP Assignment, Co-founder Agreement.
  - **Marketing & Growth:** ASO Keywords, Launch Checklist, Content Calendar, Cold Outreach Sequences.
- **Single Source Project Sync:** Enter your startup's core information once (e.g. name, problem, solution, metrics) and all 45 tools pre-fill automatically.
- **5 Full Languages:** English (`en`), Turkish (`tr`), French (`fr`), Spanish (`es`), and German (`de`) with dynamic currency switching (`$`, `₺`, `€`).
- **Privacy-First & Offline:** 100% on-device storage (SharedPreferences / KeyValueStore). Zero analytics backend; no data leaves the phone.
- **Apple & Google In-App Purchases:** Native `in_app_purchase` with StoreKit 2 & Google Play Billing, 14-day trial, and daily free quota.

---

## Run & Develop

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

### Run Tests

The test suite contains over 1,000 unit, smoke, localization, accessibility (WCAG AA), and RTL tests:

```sh
flutter test
```

---

## Store Assets (Screenshots, Previews & Banners)

Ready-to-upload store graphics and preview videos are generated via automated test scripts in `docs/store/`:

> The images and videos (about 270 MB) are **not in git**. They live in
> `../startup-toolkit-store-assets/`, and `docs/store/{screenshots,play,banners,previews}`
> are local symlinks to it (git-ignored). On a new machine, recreate the
> symlinks or regenerate the assets with the tools below.

### 1. App Store Previews (Videos)
Located in [`docs/store/previews/iphone/`](docs/store/previews/iphone/):
- Conforms strictly to Apple App Store specifications: H.264, 30 fps, 29.5s duration, stereo silent AAC track, 886x1920 resolution.
- Recorded across all 5 languages (`en.mp4`, `tr.mp4`, `fr.mp4`, `es.mp4`, `de.mp4`).
- No visible touch crosshairs; uses smooth programmatic animations and real localized sample data.

To re-record previews on a booted iOS Simulator:
```sh
tool/store_screenshots/previews.sh <SIMULATOR_ID> docs/store/previews/iphone 886x1920 "en tr fr es de"
```

### 2. App Store Screenshots
Located in [`docs/store/screenshots/`](docs/store/screenshots/):
- **iPhone 6.9" (1320x2868)**: [`docs/store/screenshots/iphone-6.9/`](docs/store/screenshots/iphone-6.9/) (10 screens per language)
- **iPad Pro 13" (2064x2752)**: [`docs/store/screenshots/ipad-13/`](docs/store/screenshots/ipad-13/) (10 screens per language)
- **iPhone Duo (Foldable, 1398x2034)**: [`docs/store/screenshots/iphone-duo/`](docs/store/screenshots/iphone-duo/)

To generate raw screenshots and compose frames:
```sh
flutter test tool/store_screenshots/capture_test.dart --dart-define=OUT=/tmp/shots/raw
python3 -I tool/store_screenshots/compose.py /tmp/shots/raw docs/store/screenshots/iphone-6.9
```

### 3. Store Listing & Banners
- **Header & Search Banners**: Located in [`docs/store/banners/`](docs/store/banners/) (header and search variations for 5 languages).
- **Localized Listing Text**: Titles, subtitles, keywords, promotional texts, and descriptions in [`docs/store/listing_l10n.json`](docs/store/listing_l10n.json).
- **Checklist & Guidelines**: Check release steps in [`docs/release/checklist.md`](docs/release/checklist.md) and privacy details in [`docs/store/privacy-labels.md`](docs/store/privacy-labels.md).

---

## Subscriptions and Billing

Purchases communicate directly with the App Store and Google Play using the official `in_app_purchase` plugin ([`lib/billing/store_billing.dart`](lib/billing/store_billing.dart)):

- **Product IDs:** Configured in [`lib/billing/billing_config.dart`](lib/billing/billing_config.dart) (e.g. `com.kahramanapp.startuptoolkit.premium.monthly`).
- **Device-Side Entitlement:** StoreKit 2 transactions verified on iOS, active subscriptions verified on Android.
- **Preview Store:** In Debug mode, a mock `PreviewBillingService` is active for fast paywall testing without needing StoreKit sandbox accounts.
- **Legal Requirements:** Standard terms of use and privacy policy URLs are configured in [`lib/core/app_info.dart`](lib/core/app_info.dart) and [`docs/legal/`](docs/legal/).

---

## Architecture & Project Structure

```text
lib/
├── billing/      # Entitlement logic, in_app_purchase integration, preview store
├── core/         # Theme tokens (AppTheme), currency formatting (Fmt, CurrencyScope), storage
├── engines/      # Pure calculation engines: CalcEngine, DocEngine, ListEngine
├── features/     # Presentation layer (Home, Project, Catalog, Tools, Paywall, Profile)
├── l10n/         # UI localization (.arb files and generated AppLocalizations)
├── project/      # Master Project model (13 core fields), auto-mapping engine
└── tools/        # 45 founder tools: ToolDef, Catalog, and category translations (l10n/)

integration_test/
└── app_preview_test.dart   # Automated script driving the 29.5s store tour

tool/
├── icon/              # App icon generator
└── store_screenshots/ # Screenshot capture, PIL compositor, banner & preview scripts
```

---

## License & Author

Developed by **Kahraman App**  
Support: `support@kahramanapp.com`
