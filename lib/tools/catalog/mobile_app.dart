import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.mobileApp;

final mobileAppTools = <ToolDef>[
  ToolDef(
    id: 'storeListing',
    name: 'Store listing writer',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.storefront_outlined,
    description: 'Title, subtitle and description for the app stores.',
    goals: {Goal.launchApp},
    fields: [
      text('app', 'App name', 'Nimbly'),
      text('subtitle', 'Subtitle (30 chars)', 'Bookkeeping for freelancers'),
      text('oneLiner', 'One-liner', 'bookkeeping that does itself'),
      text('audience', 'Audience', 'freelancers'),
      para(
        'features',
        'Key features',
        'Bank sync sorts every expense\nQuarterly tax estimate\nSnap receipts in one second\nExport for your accountant',
      ),
      text(
        'price',
        'Pricing line',
        r'Free for 14 days, then $12/month or $99/year.',
      ),
      text('proof', 'Social proof', 'Loved by 1,200 freelancers'),
    ],
    template: r'''APP NAME
{app}: {subtitle}

SUBTITLE
{subtitle}

PROMOTIONAL TEXT
{proof}. Get your evenings back.

DESCRIPTION
{app}: {oneLiner}
Built for {audience}.

WHAT YOU GET
{features|bullets}

WHY {app|upper}
• Set up in two minutes
• Private by design: we never sell your data

PRICING
{price}
Subscriptions renew automatically unless cancelled at least 24 hours before the end of the period. Manage or cancel in your account settings.

Check limits before you submit: name 30 characters, subtitle 30, promotional text 170.''',
  ),
  ToolDef(
    id: 'asoKeywords',
    name: 'ASO keyword tool',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.manage_search,
    description: 'Keyword field ideas for App Store search.',
    goals: {Goal.launchApp},
    fields: [
      text('app', 'App name', 'Nimbly'),
      text('primary', 'Primary keyword', 'bookkeeping'),
      text('secondary', 'Secondary keyword', 'expense'),
      text('audience', 'Audience', 'freelancer'),
      text(
        'keywords',
        'More keywords',
        'tracker,receipt,tax,invoice,budget,accounting,income,scanner',
        hint: 'Comma separated, no spaces',
      ),
      text(
        'competitor',
        'Competitor',
        'LedgerPro',
        hint: 'Do not use other brand names in the keyword field',
      ),
    ],
    template: r'''KEYWORD FIELD (100 characters, comma separated, no spaces)
{primary|lower},{secondary|lower},{audience|lower},{keywords|lower}

TITLE + SUBTITLE IDEAS
• {app}: {primary|cap} & {secondary|cap}s
• {app}: {primary|cap} for {audience|cap}s
• {secondary|cap} Tracker for {audience|cap}s

LONG-TAIL SEARCHES TO TARGET
• {primary|lower} app for {audience|lower}s
• {secondary|lower} tracker {audience|lower}
• self employed {primary|lower}

RULES
• Do not repeat words already in the title or subtitle.
• Use singular forms; the store matches plurals.
• Do not use competitor names like "{competitor}".
• Change one variable at a time and wait 2–4 weeks before judging.''',
  ),
  ToolDef(
    id: 'reviewReply',
    name: 'Review reply writer',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.reviews_outlined,
    description: 'Calm, helpful replies to app store reviews.',
    goals: {Goal.launchApp},
    templateField: 'kind',
    fields: [
      choice('kind', 'Review type', [
        'Positive',
        'Negative',
        'Bug report',
        'Feature request',
      ]),
      text('name', 'Reviewer name', 'Alex', autofill: false),
      text('app', 'App name', 'Nimbly'),
      text('topic', 'What they mentioned', 'bank sync'),
      email('email', 'Support email', 'help@nimbly.app'),
    ],
    templates: {
      'Positive':
          r'''Hi {name}, thank you so much! We're glad {topic} is saving you time. If you have ideas to make {app} even better, we'd love to hear them at {email}.''',
      'Negative':
          r'''Hi {name}, we're sorry {topic} let you down. That's not the experience we want for you. Please write to {email} with a few details and we'll make it right personally.''',
      'Bug report':
          r'''Hi {name}, thanks for reporting the issue with {topic}. Our team is on it and a fix is coming in the next update. If you can send your device model to {email}, it will help us confirm the fix.''',
      'Feature request':
          r'''Hi {name}, great idea! {topic|cap} is on our list and your vote moves it up. Follow along or share more details at {email}.''',
    },
  ),
  ToolDef(
    id: 'appPrivacy',
    name: 'App privacy policy',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.privacy_tip_outlined,
    description: 'A privacy policy for apps, matched to store privacy labels.',
    goals: {Goal.launchApp},
    legalDisclaimer: true,
    fields: [
      text('app', 'App name', 'Nimbly'),
      text('developer', 'Developer', 'Nimbly Inc.'),
      email('email', 'Support email', 'privacy@nimbly.app'),
      choice('account', 'Accounts', [
        'No account',
        'Account required',
        'Optional account',
      ]),
      choice('analytics', 'Analytics', [
        'No analytics',
        'Anonymous analytics',
        'Analytics linked to user',
      ]),
      choice('ads', 'Advertising', [
        'No ads',
        'Ads without tracking',
        'Ads with tracking',
      ]),
      text('date', 'Effective date', 'Oct 19, 2026'),
    ],
    template: r'''PRIVACY POLICY: {app}
Effective {date}

{developer} ("we") built {app}. This policy explains what data the app handles.

ACCOUNTS
{account}. If you create an account, you can delete it and its data from inside the app at any time.

DATA STORED ON YOUR DEVICE
Information you enter in {app} is stored on your device unless you choose to sync or share it.

ANALYTICS
{analytics}. We use analytics only to improve the app and never to identify you for advertising.

ADVERTISING AND TRACKING
{ads}. If the app ever tracks you across other companies' apps or websites, it will ask for your permission first.

PURCHASES
Payments are handled by the App Store or Google Play. We do not see your card details.

CHILDREN
{app} is not directed to children under 13.

YOUR RIGHTS
Ask for a copy of your data or its deletion at {email}.

Keep this policy consistent with the App Privacy details in App Store Connect and the Data safety form in Google Play.''',
  ),
];
