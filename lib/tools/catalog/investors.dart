import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.investors;

final investorTools = <ToolDef>[
  ToolDef(
    id: 'pitchDeck',
    name: 'Pitch deck wizard',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.slideshow_outlined,
    description: 'A 10-slide deck outline from your project.',
    goals: {Goal.raiseFunding},
    fields: [
      text('company', 'Startup name', 'Nimbly'),
      text(
        'oneLiner',
        'One-liner',
        'Bookkeeping that does itself, for freelancers.',
      ),
      para(
        'problem',
        'Problem',
        'Freelancers lose 5+ hours a month on bookkeeping and miss deductions.',
      ),
      para(
        'solution',
        'Solution',
        'Nimbly syncs the bank, sorts expenses and estimates quarterly taxes.',
      ),
      text(
        'market',
        'Market size',
        r'59M US freelancers; $4B serviceable market',
      ),
      text('model', 'Business model', r'Subscription, $12/month or $99/year'),
      para(
        'traction',
        'Traction',
        r'1,200 users, $3.5k MRR, 18% month-over-month growth',
      ),
      text(
        'competition',
        'Competition',
        'Full accounting suites (too complex), spreadsheets (manual)',
      ),
      text(
        'team',
        'Team',
        'Ada (CEO, ex-product lead), Sam (CTO), Lee (CPA, 8 years in tax software)',
      ),
      text('ask', 'The ask', r'$750k pre-seed for 18 months of runway'),
      email('email', 'Contact email', 'founders@nimbly.app'),
    ],
    template: r'''PITCH DECK OUTLINE: {company}

Slide 1. Title
{company}: {oneLiner}

Slide 2. Problem
{problem}

Slide 3. Solution
{solution}

Slide 4. Why now
What changed in the market that makes this possible today?

Slide 5. Market size
{market}

Slide 6. Product
Three screenshots and one sentence each.

Slide 7. Business model
{model}

Slide 8. Traction
{traction}

Slide 9. Competition
{competition}
Show a 2×2 where {company} sits alone in the best corner.

Slide 10. Team and the ask
{team}
Raising: {ask}
Contact: {email}

Tip: one idea per slide, large type, numbers over adjectives.''',
  ),
  ToolDef(
    id: 'onePager',
    name: 'One-pager',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.description_outlined,
    description: 'Your startup on a single page for investors.',
    goals: {Goal.raiseFunding},
    fields: [
      text('company', 'Startup name', 'Nimbly'),
      text(
        'oneLiner',
        'One-liner',
        'Bookkeeping that does itself, for freelancers.',
      ),
      para(
        'problem',
        'Problem',
        'Freelancers lose 5+ hours a month on bookkeeping and miss deductions.',
      ),
      para(
        'solution',
        'Solution',
        'Nimbly syncs the bank, sorts expenses and estimates quarterly taxes.',
      ),
      text(
        'customer',
        'Target customer',
        'US freelance designers and developers',
      ),
      text('market', 'Market size', r'$4B serviceable market'),
      text('traction', 'Traction', r'1,200 users, $3.5k MRR, +18% MoM'),
      text('team', 'Team', 'Ada (CEO), Sam (CTO), Lee (CPA)'),
      text('ask', 'The ask', r'$750k pre-seed'),
      email('email', 'Contact email', 'founders@nimbly.app'),
    ],
    template: r'''{company|upper}
{oneLiner}

PROBLEM
{problem}

SOLUTION
{solution}

CUSTOMER
{customer}

MARKET
{market}

TRACTION
{traction}

TEAM
{team}

THE ASK
{ask}

Contact: {email}''',
  ),
  ToolDef(
    id: 'investorTracker',
    name: 'Investor tracker',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.handshake_outlined,
    description: 'Your fundraising pipeline, stage by stage.',
    goals: {Goal.raiseFunding},
    itemLabel: 'Investor',
    stages: ['To contact', 'Contacted', 'Meeting', 'Committed', 'Passed'],
    totalField: 'amount',
    fields: [
      text('firm', 'Firm', 'Angel'),
      money('amount', 'Check size', 50000, autofill: false),
      text('next', 'Next step', 'Send deck'),
    ],
    samples: [
      const SampleItem('Maya Chen', 'Meeting', {
        'firm': 'Northstar Ventures',
        'amount': 250000,
        'next': 'Partner meeting Thursday',
      }),
      const SampleItem('Jordan Ellis', 'Committed', {
        'firm': 'Angel',
        'amount': 50000,
        'next': 'Send SAFE',
      }),
      const SampleItem('Seedcamp-style fund', 'To contact', {
        'firm': 'Pre-seed fund',
        'amount': 150000,
        'next': 'Ask Jordan for intro',
      }),
    ],
  ),
  ToolDef(
    id: 'valuation',
    name: 'Valuation estimate',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.trending_up,
    description: 'A rough ARR-multiple range. Not a valuation.',
    goals: {Goal.raiseFunding},
    formula: 'valuation',
    heroOutput: 'mid',
    fields: [
      money(
        'arr',
        'Annual recurring revenue',
        42000,
        min: 0,
        max: 5000000,
        step: 1000,
      ),
      percent('growth', 'Yearly growth', 120, min: 0, max: 400, step: 5),
    ],
  ),
];
