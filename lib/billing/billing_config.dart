/// Store and legal settings, passed at build time so no keys live in git:
///
/// ```sh
/// flutter run \
///   --dart-define=RC_APPLE_KEY=appl_xxx \
///   --dart-define=RC_GOOGLE_KEY=goog_xxx \
/// ```
///
/// Terms (Apple's standard EULA) and the privacy policy have published
/// defaults; `--dart-define=TERMS_URL=…` / `PRIVACY_URL=…` override them.
///
/// Without a RevenueCat key, debug builds use a preview store with
/// placeholder prices and release builds turn purchases off.
abstract final class BillingConfig {
  static const appleKey = String.fromEnvironment('RC_APPLE_KEY');
  static const googleKey = String.fromEnvironment('RC_GOOGLE_KEY');

  /// RevenueCat entitlement that unlocks every tool.
  static const entitlementId = 'pro';

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
