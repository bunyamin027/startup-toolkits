# Privacy labels — answers for v1.0

Based on the app as built: no account, content stored on device, no
analytics backend, no servers of our own, purchases directly through the
App Store / Google Play (StoreKit / Play Billing, no third-party SDK).
Re-check if any of that changes.

## Apple App Store Connect → App Privacy

**Do you or your third-party partners collect data from this app?**
**No** → the label reads "Data Not Collected".

Notes:
- Purchases are processed by Apple, which is not counted as collection by
  the developer.
- **User Content** (project, tool inputs) is not collected: it never leaves
  the device.
- **Tracking:** none, so no App Tracking Transparency prompt.
- If you add Firebase Analytics or PostHog, add **Usage Data → Product
  Interaction** (and Diagnostics if crash reporting is on) and update the
  privacy policy.

## Google Play → Data safety

- Data collected: none. Purchases are processed by Google Play.
- Data shared: none.
- Data encrypted in transit: not applicable (the app sends no data).
- Users can request deletion: local data via Profile → Delete all data.
- Account creation: none.
