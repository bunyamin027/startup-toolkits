# Release checklist — v1.0.0

Status as of 19 Oct 2026. ✅ done in the codebase · ⬜ needs you (accounts,
URLs, decisions) · ⚠️ verify before submitting.

## 1. Before the first build

- ⬜ Move the project out of the iCloud-synced Desktop (for example to
  `~/Developer`). iOS builds fail inside iCloud folders with "resource fork,
  Finder information, or similar detritus not allowed".
- ⬜ Android: run `flutter doctor --android-licenses` and accept the SDK
  licenses.
- ✅ Bundle ID / application ID: `com.kahramanapp.startuptoolkit` on
  both platforms. It cannot change after the first upload.
- ⬜ Android release signing: create an upload keystore and
  `android/key.properties`, and point the `release` build type at it
  (today it signs with the debug key).

## 2. Accounts and products

- ⬜ App Store Connect app record (name **Startup Toolkit: 45 in 1**; the home-screen name stays "Startup Toolkit", primary
  language English).
- ✅ Subscription group and products as in
  `docs/store/app-store-listing.md`, prices set in all territories. No
  intro offer: the trial is the app's own 14 days.
- ⬜ Google Play Console app and subscriptions with the same product IDs.
- ✅ Trial type: 14-day in-app trial only.

## 3. Legal and URLs

- ⬜ Fill the [BRACKETS] in `docs/legal/privacy-policy.md` and
  `docs/legal/terms-of-use.md`, have a lawyer review, publish them.
- ⬜ Support URL (a simple page with an email address is enough).
- ✅ Paywall and Profile link to Terms and Privacy (from build-time URLs).

## 4. Build

```sh
flutter build ipa --release
flutter build appbundle --release
```

Archiving from Xcode (Product → Archive) works too; no build-time keys
are needed.

- ✅ Version 1.0.0 (build 2) in `pubspec.yaml`; Profile shows it (a test
  keeps them in sync). Bump the build number for every upload.
- ✅ Release builds compile for iOS (unsigned) and Android (debug APK)
  as of this checklist.

## 5. Store listing (`docs/store/`)

- ✅ Name, subtitle, keywords, promotional text, description, What's New,
  categories, age rating, review notes (limits checked).
- ✅ App icon in every iOS and Android size, no alpha on the 1024 master
  (`tool/icon/generate_icon.py`).
- ✅ iPhone 6.5" screenshots (`docs/store/screenshots/iphone-6.5`).
  ⬜ Add the display size App Store Connect currently marks as required
  (6.9" at the time of writing) from the matching simulator.
- ⬜ Paywall screenshot for each subscription's App Review information.
- ✅ Privacy label and Data safety answers (`docs/store/privacy-labels.md`).

## 6. Quality gates (automated, `flutter test`)

- ✅ Formulas, template engine, field mapping, daily allowance.
- ✅ All 45 tools open with example data and render every template variant.
- ✅ Every screen and tool fits an iPhone SE at 2× Dynamic Type.
- ✅ iOS 44 pt tap targets, labelled buttons, 4.5:1 text contrast on main
  screens.
- ✅ VoiceOver: sliders and results read as single phrases.
- ✅ Reduce Motion: no running animations on Home or the paywall.
- ✅ Paywall: store prices, auto-renew terms, Restore, Terms, Privacy.

## 7. Internal test (TestFlight / Play internal testing)

Run on a small iPhone, a large iPhone and one Android phone. Sandbox
accounts for purchases.

1. Fresh install → Welcome → pick a goal → name the startup → Home shows
   the name, "Trial · 14 days left" and goal-based tools.
2. Next best step opens the suggested tool; edit a field, go back, Project
   shows it filled.
3. Open a calculator, document and tracker: copy, share and save to
   project work; the share sheet appears correctly (iPad: anchored).
4. Turn on **Larger Text** (max), **Bold Text**, **Reduce Motion** and
   **VoiceOver**; repeat steps 1–3.
5. Paywall from Profile → See plans: prices and terms match App Store
   Connect; buy yearly with Sandbox → "Pro"; delete and reinstall →
   Restore Purchases brings Pro back.
6. Free plan (Sandbox, after the trial or with a fresh Apple ID past
   trial): first tool opens, second shows the free limit sheet, next day
   resets.
7. Airplane mode: tools keep working; a subscriber stays Pro.
8. Profile → Delete all data → Welcome again; trial days unchanged.

## 8. Submit

- ⬜ App Review notes from `docs/store/app-store-listing.md`.
- ⬜ Export compliance: the app uses only standard HTTPS (exempt).
- ⬜ Phased release on; monitor App Store Connect sales for the first purchases.
