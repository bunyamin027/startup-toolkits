import 'package:flutter/foundation.dart';

/// Store products and legal links.
///
/// Google Play caps subscription IDs at 40 characters, so Android uses
/// short IDs; the App Store ones were created first and cannot change.
/// Terms (Apple's standard EULA) and the privacy policy have published
/// defaults; `--dart-define=TERMS_URL=…` / `PRIVACY_URL=…` override them.
abstract final class BillingConfig {
  static bool get _play => defaultTargetPlatform == TargetPlatform.android;

  static String get yearlyId =>
      _play ? 'pro.yearly' : 'com.kahramanapp.startuptoolkit.pro.yearly';
  static String get monthlyId =>
      _play ? 'pro.monthly' : 'com.kahramanapp.startuptoolkit.pro.monthly';
  static Set<String> get productIds => {yearlyId, monthlyId};

  static const termsUrl = String.fromEnvironment(
    'TERMS_URL',
    defaultValue:
        'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/',
  );
  static const privacyUrl = String.fromEnvironment(
    'PRIVACY_URL',
    defaultValue: 'https://www.kahramanapp.com/privacy',
  );
}
