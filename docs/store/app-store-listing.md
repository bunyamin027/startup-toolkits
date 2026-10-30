# Store listing — Startup Toolkit (English, v1.0)

Character limits checked against App Store Connect. Placeholders in
[BRACKETS].

## App Store Connect

| Field | Value | Limit |
|---|---|---|
| Name | Startup Toolkit: 45 in 1 | 24 / 30 |
| Subtitle | Pitch deck, runway & legal | 26 / 30 |
| Primary category | Business | |
| Secondary category | Productivity | |
| Age rating | 4+ (no objectionable content) | |
| Price | Free with in-app subscriptions | |
| Support URL | https://www.kahramanapp.com/#contact | |
| Marketing URL | [MARKETING URL] (optional) | |
| Privacy Policy URL | https://www.kahramanapp.com/privacy | |
| Terms of Use (EULA) | Apple standard EULA: https://www.apple.com/legal/internet-services/itunes/dev/stdeula/ | |

### Keywords (99 / 100)

```
entrepreneur,business,lean,canvas,invoice,nda,cap,table,crm,okr,swot,investor,valuation,mvp,aso,kpi
```

Words already in the name or subtitle (startup, toolkits, pitch, deck,
runway, legal) are left out; Apple indexes them anyway.

### Promotional text (145 / 170)

Raise funding, find customers, set up the company or launch your app: 45
tools that fill themselves from your startup details. No account needed.

### Description

Startup Toolkit puts the 45 tools a founder needs in one app, and they
work together: enter your startup details once, and your pitch deck,
one-pager, runway and documents fill themselves.

START WITH YOUR GOAL
Tell us what you're building toward (raise funding, find first customers,
set up the company or launch your app) and Mission Control shows your
launch path and the next best step.

CALCULATORS
• Runway & burn rate
• Unit economics (LTV, CAC, payback)
• Pricing, cap table and valuation estimate
• Idea scoring, A/B test significance, conversion funnel

DOCUMENTS IN SECONDS
• Lean Canvas, SWOT, personas, interview scripts
• Pitch deck outline and investor one-pager
• Invoices, proposals, job posts, PRDs
• Landing page copy, email templates, brand names, SEO and ASO keywords
• App Store listings and review replies
• NDA, contractor and partnership agreements, privacy policy and terms
  (templates, not legal advice)

TRACKERS
• Investor pipeline, mini CRM, follow-ups, customer feedback
• Kanban, OKRs, roadmap, stand-ups, meeting actions
• Competitors, content calendar, KPI board, income and expenses

PRIVATE BY DESIGN
No account. Everything you enter stays on your device.

TRY EVERYTHING FREE FOR 14 DAYS
Every tool is open for 14 days. After that, keep using one tool a day for
free, or go Pro for unlimited access.

SUBSCRIPTION TERMS
Startup Toolkit Pro is available as a monthly or yearly auto-renewing
subscription. Payment is charged to your Apple ID account at confirmation
of purchase. Subscriptions renew automatically unless cancelled at least
24 hours before the end of the current period; your account is charged
for renewal within 24 hours before the end of the period. Manage or cancel
in your App Store account settings. Every tool is free for the first 14
days after install, with no purchase or sign-up needed.

Terms of Use: https://www.apple.com/legal/internet-services/itunes/dev/stdeula/
Privacy Policy: https://www.kahramanapp.com/privacy

### What's New (1.0)

First release: 45 founder tools, project auto-fill, launch path and
next best step.

## In-app purchases (App Store Connect)

Subscription group: **Startup Toolkit Pro**

| Reference name | Product ID | Duration | Price (assumption, §6) | Intro offer |
|---|---|---|---|---|
| Pro Yearly | com.kahramanapp.startuptoolkit.pro.yearly | 1 year | $49.99 | None |
| Pro Monthly | com.kahramanapp.startuptoolkit.pro.monthly | 1 month | $6.99 | None |

Localized display name: "Startup Toolkit Pro". Description (≤55):
"Unlimited access to all 45 founder tools" (40).

Product IDs: `com.kahramanapp.startuptoolkit.pro.yearly` and
`com.kahramanapp.startuptoolkit.pro.monthly` (no intro offer; the app has
its own 14-day trial). Google Play caps subscription IDs at 40
characters, so Android uses `pro.yearly` (base plan `yearly`) and
`pro.monthly` (base plan `monthly`); `BillingConfig` picks the IDs by
platform. A review screenshot of the paywall is required for
each product.

## App Review notes

> No login is required. Every tool is unlocked for the first 14 days after
> install. To see the free plan, the trial must have ended; to test
> purchases, use a Sandbox account on the paywall (Profile → See plans).
> Legal templates show a "not legal advice" notice. All user content is
> stored on the device.

## Screenshots

Ten per language (en, tr, fr, es, de), uploaded to App Store Connect:

- iPhone 6.9" (1320 × 2868): `docs/store/screenshots/iphone-6.9/<lang>/`
- iPad 13" (2064 × 2752): `docs/store/screenshots/ipad-13/<lang>/`
- iPhone Duo, unfolded (1398 × 2034): `docs/store/screenshots/iphone-duo/<lang>/`
- Product page header (3840 × 1646) and search results asset
  (1920 × 1280): `docs/store/banners/{header,search}/<lang>.png`, made by
  `tool/store_screenshots/banners.py` from the iPhone captures.

Headlines are in `tool/store_screenshots/captions.json`. To regenerate
after an app or caption change, see the commands at the top of
`tool/store_screenshots/capture_test.dart` (add `DEVICE=ipad` and the
`ipad` argument for the iPad set). The old 6.5" captures in
`docs/store/screenshots/iphone-6.5/` predate the current design.
