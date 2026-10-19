import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.marketing;

final marketingTools = <ToolDef>[
  ToolDef(
    id: 'brandName',
    name: 'Brand name & slogan',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.auto_awesome_outlined,
    description: 'Name ideas and taglines from a few keywords.',
    goals: {Goal.launchApp, Goal.setUpCompany},
    fields: [
      text(
        'keyword',
        'Main keyword',
        'ledger',
        hint: 'One word that describes the product',
      ),
      text('keyword2', 'Second keyword', 'nimble'),
      text('benefit', 'Main benefit', 'keep more of what you earn'),
      text('audience', 'Audience', 'freelancers'),
    ],
    template: r'''NAME IDEAS
• {keyword|cap}ly
• {keyword2|cap}
• Get{keyword|cap}
• {keyword|cap}Hub
• {keyword2|cap}{keyword|cap}
• {keyword|cap}ify
• Hey{keyword|cap}
• {keyword|cap}Base
• Try{keyword2|cap}
• {keyword2|cap}io

SLOGANS
• {benefit|cap}.
• Built for {audience}. Ready in minutes.
• The {keyword|lower} that works while you work.
• Less admin. More {audience}.
• {keyword2|cap} by design.

Before you pick: check the .com and app store names, search trademarks, and say it out loud to five people.''',
  ),
  ToolDef(
    id: 'colorPalette',
    name: 'Color palette & logo idea',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.palette_outlined,
    description: 'A starter palette and logo direction by brand mood.',
    goals: {Goal.launchApp},
    templateField: 'mood',
    fields: [
      text('company', 'Startup name', 'Nimbly'),
      choice('mood', 'Brand mood', [
        'Trustworthy',
        'Bold',
        'Calm',
        'Playful',
        'Premium',
      ]),
    ],
    templates: {
      'Trustworthy': r'''PALETTE: TRUSTWORTHY ({company})
Primary   #1F4FD8  deep blue
Secondary #14B8A6  teal
Accent    #F59E0B  amber, for calls to action
Neutral   #0F172A / #F8FAFC
Use blue for headers and buttons, amber only for the one action you want.

LOGO IDEA
A simple wordmark "{company}" in a geometric sans with a small check mark or shield folded into the first letter.''',
      'Bold': r'''PALETTE: BOLD ({company})
Primary   #E11D48  crimson
Secondary #111827  near black
Accent    #FACC15  yellow
Neutral   #F9FAFB
High contrast; keep large areas black or white so the red stays loud.

LOGO IDEA
Heavy condensed wordmark "{company|upper}" with one letter cut diagonally.''',
      'Calm': r'''PALETTE: CALM ({company})
Primary   #4F8A8B  sage teal
Secondary #A7C4BC  mist
Accent    #F4A261  soft orange
Neutral   #FBFAF7 / #2B2D42
Generous white space, rounded shapes.

LOGO IDEA
Lowercase "{company|lower}" in a rounded sans with a soft circle or leaf mark.''',
      'Playful': r'''PALETTE: PLAYFUL ({company})
Primary   #7C3AED  violet
Secondary #22D3EE  cyan
Accent    #FB7185  coral
Neutral   #FFFFFF / #1E1B4B
Mix colors freely in illustrations; keep text dark on light.

LOGO IDEA
A friendly mascot or blob shape next to "{company}" in a rounded, slightly bouncy font.''',
      'Premium': r'''PALETTE: PREMIUM ({company})
Primary   #0B1020  midnight
Secondary #C9A227  muted gold
Accent    #E5E7EB  silver
Neutral   #FAFAF9
Use gold sparingly: lines, icons, one highlight per screen.

LOGO IDEA
Spaced capitals "{company|upper}" in a high-contrast serif, or a monogram of the first letter in a thin frame.''',
    },
  ),
  ToolDef(
    id: 'contentCalendar',
    name: 'Content calendar',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.calendar_month_outlined,
    description: 'Plan posts from idea to published.',
    goals: {Goal.firstCustomers, Goal.launchApp},
    itemLabel: 'Post',
    stages: ['Idea', 'Drafting', 'Scheduled', 'Published'],
    fields: [
      text('channel', 'Channel', 'LinkedIn'),
      text('date', 'Date', 'Mon'),
    ],
    samples: [
      const SampleItem('5 deductions freelancers forget', 'Scheduled', {
        'channel': 'Blog',
        'date': 'Oct 22',
      }),
      const SampleItem('Behind the build: bank sync', 'Drafting', {
        'channel': 'LinkedIn',
        'date': 'Oct 24',
      }),
      const SampleItem('Quarterly tax deadline reminder', 'Idea', {
        'channel': 'Instagram',
        'date': 'Jan 10',
      }),
    ],
  ),
  ToolDef(
    id: 'landingPage',
    name: 'Landing page copy',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.web_outlined,
    description: 'Hero, benefits, social proof and call to action.',
    goals: {Goal.firstCustomers, Goal.launchApp},
    fields: [
      text('company', 'Product name', 'Nimbly'),
      text('audience', 'Target audience', 'freelancers'),
      text('outcome', 'Main outcome', 'Bookkeeping that does itself'),
      para(
        'problem',
        'Problem',
        'You became a freelancer to do great work, not to chase receipts.',
      ),
      para(
        'features',
        'Top 3 features',
        'Bank sync sorts every expense\nQuarterly tax estimate, always up to date\nSnap receipts in one second',
      ),
      text('proof', 'Social proof', 'Trusted by 1,200 freelancers'),
      text('cta', 'Call to action', 'Start free'),
    ],
    template: r'''HERO
{outcome}.
{company} is built for {audience}.
→ {cta}

PROBLEM
{problem}

HOW {company|upper} HELPS
{features|bullets}

SOCIAL PROOF
{proof}

FAQ
• How long does setup take? About two minutes.
• Can I cancel anytime? Yes, in one tap.
• Is my data safe? Bank-level encryption, and we never sell data.

FINAL CALL TO ACTION
Ready to get your time back? → {cta}''',
  ),
  ToolDef(
    id: 'emailTemplates',
    name: 'Email templates',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.mail_outline,
    description: 'Cold outreach, follow-up, investor update, thank you.',
    goals: {Goal.firstCustomers, Goal.raiseFunding},
    templateField: 'type',
    fields: [
      choice('type', 'Email type', [
        'Cold outreach',
        'Follow-up',
        'Investor update',
        'Thank you',
      ]),
      text('recipient', 'Recipient first name', 'Jordan', autofill: false),
      text('sender', 'Your name', 'Ada'),
      text('company', 'Startup name', 'Nimbly'),
      text(
        'oneLiner',
        'One-liner',
        'bookkeeping that does itself, for freelancers',
      ),
      text('hook', 'Personal hook', 'your talk on solo founders at SaaStr'),
      text('traction', 'Traction', r'$3.5k MRR, up 18% this month'),
      text('ask', 'Ask', 'a 20-minute call next week'),
    ],
    templates: {
      'Cold outreach': r'''Subject: Quick question, {recipient}

Hi {recipient},

I loved {hook}. I'm {sender}, founder of {company}: {oneLiner}.

We're at {traction}, and I think you'd have a sharp view on where we go next.

Would you be open to {ask}?

Thanks,
{sender}''',
      'Follow-up': r'''Subject: Re: Quick question, {recipient}

Hi {recipient},

Bumping this in case it got buried. Since my last note: {traction}.

Still keen on {ask}. If now isn't a good time, just say so and I'll check back next quarter.

Best,
{sender}''',
      'Investor update': r'''Subject: {company} update: {traction}

Hi {recipient},

Highlights
• {traction}

Lowlights
• What didn't work this month and what we learned.

Asks
• {ask}

Thanks for the support,
{sender}''',
      'Thank you': r'''Subject: Thank you, {recipient}

Hi {recipient},

Thank you for your time today. Your point about {hook} was especially helpful.

As promised, I'll follow up with next steps by Friday.

Best,
{sender}
{company}''',
    },
  ),
  ToolDef(
    id: 'seoKeywords',
    name: 'SEO keyword ideas',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.travel_explore,
    description: 'Search terms your customers type.',
    goals: {Goal.firstCustomers},
    fields: [
      text('topic', 'Topic', 'bookkeeping'),
      text('audience', 'Audience', 'freelancers'),
      text('alternative', 'Known competitor or alternative', 'spreadsheets'),
      text('location', 'Location', 'US'),
    ],
    template: r'''HIGH INTENT (ready to buy)
• best {topic} app for {audience}
• {topic} software for {audience}
• {topic} tool pricing
• {alternative} alternative for {topic}

PROBLEM (looking for help)
• how to do {topic} as a freelancer
• {topic} tips for {audience}
• {topic} mistakes to avoid
• {topic} checklist for {audience}

LOCAL
• {topic} for {audience} in {location}
• {topic} rules {location} {audience}

LONG TAIL BLOG IDEAS
• {topic|cap} for {audience}: a beginner's guide
• {alternative|cap} vs apps for {topic}: which is better?
• How much time does {topic} take each month?

Next: check volume and difficulty in a keyword tool, then write one page per high-intent term.''',
  ),
];
