# Privacy labels — answers for v1.0

Based on the app as built: no account, content stored on device, no
analytics backend, purchases via RevenueCat. Re-check if any of that
changes, and confirm RevenueCat's current guidance before submitting
([RevenueCat: Apple App Privacy](https://www.revenuecat.com/docs/platform-resources/apple-platform-resources/apple-app-privacy)).

## Apple App Store Connect → App Privacy

**Do you or your third-party partners collect data from this app?** Yes
(RevenueCat processes purchase data).

| Data type | Collected | Linked to user | Tracking | Purpose |
|---|---|---|---|---|
| Purchases → Purchase History | Yes | No | No | App Functionality |
| Identifiers → User ID / Device ID | No (RevenueCat's anonymous ID is not linked to a person) | — | — | — |
| Contact info, Health, Financial info, Location, Contacts, User Content, Browsing, Search, Usage Data, Diagnostics | No | — | — | — |

Notes:
- **User Content** (project, tool inputs) is not collected: it never leaves
  the device.
- **Tracking:** none, so no App Tracking Transparency prompt.
- If you add Firebase Analytics or PostHog, add **Usage Data → Product
  Interaction** (and Diagnostics if crash reporting is on) and update the
  privacy policy.

## Google Play → Data safety

- Data collected: **Financial info → Purchase history** (by RevenueCat),
  purpose App functionality; not shared for advertising.
- Data shared: none.
- Data encrypted in transit: Yes.
- Users can request deletion: Yes (local data via Profile → Delete all
  data; purchase data via kahramandev01@gmail.com).
- Account creation: none.
