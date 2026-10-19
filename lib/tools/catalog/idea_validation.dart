import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

// Example startup used across the catalog: Nimbly, bookkeeping for freelancers.

const _cat = ToolCategory.ideaValidation;

final ideaValidationTools = <ToolDef>[
  ToolDef(
    id: 'leanCanvas',
    name: 'Lean Canvas',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.dashboard_outlined,
    description: 'Your business model on one page.',
    goals: {Goal.raiseFunding, Goal.firstCustomers},
    fields: [
      text('company', 'Startup name', 'Nimbly'),
      para(
        'problem',
        'Problem',
        'Freelancers lose 5+ hours a month on bookkeeping.\n'
            'They miss tax deductions.\n'
            'Quarterly tax estimates are guesswork.',
      ),
      para(
        'solution',
        'Solution',
        'Bank sync with automatic expense categories.\n'
            'Quarterly tax estimate on one screen.\n'
            'Receipt capture by photo.',
      ),
      text(
        'uvp',
        'Unique value proposition',
        'Bookkeeping that does itself, so freelancers keep more of what they earn.',
      ),
      text(
        'segment',
        'Customer segment',
        'Freelance designers and developers in the US',
      ),
      para(
        'channels',
        'Channels',
        'Freelancer communities\nYouTube tutorials\nAccountant referrals',
      ),
      para(
        'revenue',
        'Revenue streams',
        r'Subscription: $12/month or $99/year',
      ),
      para(
        'costs',
        'Cost structure',
        'Bank data API\nCloud hosting\nPaid acquisition',
      ),
      para(
        'metrics',
        'Key metrics',
        'Weekly active users\nTrial to paid conversion\nMonthly churn',
      ),
      text(
        'advantage',
        'Unfair advantage',
        'Founding team includes a CPA who built tax software for 8 years.',
      ),
    ],
    template: r'''LEAN CANVAS: {company}

1. PROBLEM
{problem|bullets}

2. CUSTOMER SEGMENT
{segment}

3. UNIQUE VALUE PROPOSITION
{uvp}

4. SOLUTION
{solution|bullets}

5. CHANNELS
{channels|bullets}

6. REVENUE STREAMS
{revenue|bullets}

7. COST STRUCTURE
{costs|bullets}

8. KEY METRICS
{metrics|bullets}

9. UNFAIR ADVANTAGE
{advantage}''',
  ),
  ToolDef(
    id: 'swot',
    name: 'SWOT analysis',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.grid_view,
    description: 'Strengths, weaknesses, opportunities and threats.',
    goals: {Goal.raiseFunding},
    fields: [
      text('company', 'Startup name', 'Nimbly'),
      para(
        'strengths',
        'Strengths',
        'Tax expertise in the team\nSimple, focused product\nLow price',
      ),
      para(
        'weaknesses',
        'Weaknesses',
        'Small marketing budget\nUS only\nNo mobile app yet',
      ),
      para(
        'opportunities',
        'Opportunities',
        'Freelance workforce keeps growing\nAccountants want to refer simple tools\nNew e-invoicing rules',
      ),
      para(
        'threats',
        'Threats',
        'Large accounting suites add freelancer plans\nBank API price increases',
      ),
    ],
    template: r'''SWOT ANALYSIS: {company}

STRENGTHS (internal, helpful)
{strengths|bullets}

WEAKNESSES (internal, harmful)
{weaknesses|bullets}

OPPORTUNITIES (external, helpful)
{opportunities|bullets}

THREATS (external, harmful)
{threats|bullets}

NEXT STEPS
• Use strengths to capture: {opportunities|first}…
• Fix the weakness that blocks growth most.
• Plan a response to the biggest threat before it arrives.''',
  ),
  ToolDef(
    id: 'competitors',
    name: 'Competitor tracker',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.radar,
    description: 'Who else solves this problem, and how.',
    goals: {Goal.raiseFunding, Goal.firstCustomers},
    itemLabel: 'Competitor',
    stages: ['Direct', 'Indirect', 'Watch'],
    fields: [
      text('price', 'Price', r'$15/month'),
      text('strength', 'Strength', 'Brand'),
      text('weakness', 'Weakness', 'Complex'),
    ],
    samples: [
      const SampleItem('LedgerPro', 'Direct', {
        'price': r'$25/month',
        'strength': 'Full accounting suite',
        'weakness': 'Too complex for solo freelancers',
      }),
      const SampleItem('Spreadsheets', 'Indirect', {
        'price': 'Free',
        'strength': 'Flexible, already known',
        'weakness': 'Manual, error-prone',
      }),
      const SampleItem('TaxBot', 'Watch', {
        'price': r'$8/month',
        'strength': 'Cheap',
        'weakness': 'No bank sync',
      }),
    ],
  ),
  ToolDef(
    id: 'persona',
    name: 'Persona builder',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.person_outline,
    description: 'A clear picture of the customer you build for.',
    goals: {Goal.firstCustomers, Goal.launchApp},
    fields: [
      text('name', 'Persona name', 'Designer Dana'),
      text('role', 'Role', 'Freelance UI designer'),
      text('age', 'Age', '29'),
      text('location', 'Location', 'Austin, Texas'),
      para(
        'goals',
        'Goals',
        'Grow income to six figures\nSpend time on design, not admin',
      ),
      para(
        'pains',
        'Biggest problem',
        'Hates bookkeeping and pays penalties for late tax estimates',
        autofill: false,
      ),
      para(
        'tools',
        'Tools they use today',
        'Figma\nNotion\nA spreadsheet for expenses',
      ),
      text(
        'quote',
        'Quote',
        'I became a freelancer to design, not to do accounting.',
      ),
      para(
        'channels',
        'Where to reach them',
        'Dribbble\nDesign Twitter\nFreelancer Slack groups',
      ),
    ],
    template: r'''PERSONA: {name}

{role}, {age}, {location}

"{quote}"

GOALS
{goals|bullets}

PAINS
{pains|bullets}

CURRENT TOOLS
{tools|bullets}

WHERE TO REACH THEM
{channels|bullets}

How we help: show {name|first} how much time and money they get back in the first week.''',
  ),
  ToolDef(
    id: 'interviewQuestions',
    name: 'Interview & survey questions',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.question_answer_outlined,
    description: 'Customer interview scripts that avoid leading questions.',
    goals: {Goal.firstCustomers},
    templateField: 'stage',
    fields: [
      choice('stage', 'Interview type', [
        'Problem discovery',
        'Solution validation',
        'Pricing',
      ]),
      text('segment', 'Target customer', 'Freelance designers'),
      text(
        'problemArea',
        'Problem area',
        'bookkeeping and taxes',
        autofill: false,
      ),
      text('product', 'Product name', 'Nimbly'),
    ],
    templates: {
      'Problem discovery': r'''PROBLEM DISCOVERY INTERVIEW
Audience: {segment}

Warm-up
1. Tell me about your work. What does a typical week look like?
2. How long have you been doing this?

The problem
3. Walk me through the last time you dealt with {problemArea}.
4. What was the hardest part?
5. How often does this happen?
6. What do you do about it today? Which tools or people help?
7. What does it cost you, in time or money?
8. Have you tried to solve it another way? Why did you stop?

Wrap-up
9. If you had a magic wand, what would change?
10. Who else should I talk to about this?

Tips: ask about past behavior, not opinions about the future. Do not pitch.''',
      'Solution validation': r'''SOLUTION VALIDATION INTERVIEW
Audience: {segment}
Product: {product}

1. Remind me how you handle {problemArea} today.
2. (Show the prototype.) What do you think this does?
3. Try to complete this task. Think aloud as you go.
4. What was confusing or slow?
5. What is missing for this to replace what you use today?
6. Which part would you use most?
7. If {product} disappeared tomorrow, how would you feel?
8. Would you like to be in our first beta group?

Tips: let silence happen. Watch what they do, not just what they say.''',
      'Pricing': r'''PRICING INTERVIEW (Van Westendorp)
Audience: {segment}
Product: {product}

1. At what monthly price would {product} be so cheap that you would doubt its quality?
2. At what price is it a bargain, a great buy for the money?
3. At what price does it start to feel expensive, but you would still consider it?
4. At what price is it too expensive to consider?
5. What do you pay today for tools related to {problemArea}?
6. Who approves this purchase?
7. Would you prefer monthly or yearly billing? Why?

Tip: plot answers to 1–4 to find the acceptable price range.''',
    },
  ),
  ToolDef(
    id: 'ideaScore',
    name: 'Idea scoring matrix',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.lightbulb_outline,
    description: 'Score an idea on six criteria before you build.',
    goals: {Goal.raiseFunding, Goal.firstCustomers},
    formula: 'ideaScore',
    heroOutput: 'ratio',
    fields: [
      score('problemPain', 'Problem pain', 4, hint: 'How much it hurts today'),
      score('marketSize', 'Market size', 4),
      score('willingnessToPay', 'Willingness to pay', 3),
      score(
        'competition',
        'Room vs. competition',
        3,
        hint: '5 = few strong rivals',
      ),
      score('feasibility', 'Feasibility', 4, hint: 'Can your team build it?'),
      score('founderFit', 'Founder fit', 5),
    ],
  ),
];
