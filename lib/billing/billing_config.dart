/// Store products and legal links.
///
/// The product IDs are the same on the App Store and Google Play. Terms
/// (Apple's standard EULA) and the privacy policy have published defaults;
/// `--dart-define=TERMS_URL=…` / `PRIVACY_URL=…` override them.
abstract final class BillingConfig {
  static const yearlyId = 'com.kahramanapp.startuptoolkit.pro.yearly';
  static const monthlyId = 'com.kahramanapp.startuptoolkit.pro.monthly';
  static const productIds = {yearlyId, monthlyId};

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
