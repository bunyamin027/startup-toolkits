import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.product;

final productTools = <ToolDef>[
  ToolDef(
    id: 'kanban',
    name: 'Kanban',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.view_kanban_outlined,
    description: 'To do, doing, done.',
    goals: {Goal.launchApp, Goal.setUpCompany},
    itemLabel: 'Task',
    stages: ['To do', 'Doing', 'Done'],
    fields: [text('owner', 'Owner', 'Ada'), text('due', 'Due', 'Friday')],
    samples: [
      const SampleItem('Design onboarding screens', 'Doing', {
        'owner': 'Ada',
        'due': 'Wed',
      }),
      const SampleItem('Bank sync error handling', 'To do', {
        'owner': 'Sam',
        'due': 'Fri',
      }),
      const SampleItem('Set up analytics', 'Done', {
        'owner': 'Sam',
        'due': 'Mon',
      }),
    ],
  ),
  ToolDef(
    id: 'okr',
    name: 'OKR tracker',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.flag_outlined,
    description: 'Objectives and key results for the quarter.',
    goals: {Goal.setUpCompany, Goal.raiseFunding},
    itemLabel: 'Key result',
    stages: ['Not started', 'On track', 'At risk', 'Done'],
    fields: [
      text('objective', 'Objective', 'Find product-market fit'),
      percent('progress', 'Progress', 0),
    ],
    samples: [
      const SampleItem('Reach 2,000 weekly active users', 'On track', {
        'objective': 'Find product-market fit',
        'progress': 60,
      }),
      const SampleItem('Trial-to-paid above 8%', 'At risk', {
        'objective': 'Find product-market fit',
        'progress': 35,
      }),
      const SampleItem('Close pre-seed round', 'Not started', {
        'objective': 'Fund the next 18 months',
        'progress': 0,
      }),
    ],
  ),
  ToolDef(
    id: 'roadmap',
    name: 'Roadmap',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.route_outlined,
    description: 'Now, next, later.',
    goals: {Goal.launchApp, Goal.raiseFunding},
    itemLabel: 'Feature',
    stages: ['Now', 'Next', 'Later'],
    fields: [text('why', 'Why it matters', 'Most requested')],
    samples: [
      const SampleItem('Receipt capture by photo', 'Now', {
        'why': 'Top request in interviews',
      }),
      const SampleItem('Android app', 'Next', {'why': '40% of the waitlist'}),
      const SampleItem('Accountant sharing', 'Later', {
        'why': 'Opens referral channel',
      }),
    ],
  ),
  ToolDef(
    id: 'userStory',
    name: 'User story & PRD',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.article_outlined,
    description: 'A user story with acceptance criteria and a short PRD.',
    goals: {Goal.launchApp},
    fields: [
      text('feature', 'Feature name', 'Receipt capture'),
      text('user', 'As a…', 'freelancer'),
      text('want', 'I want to…', 'snap a photo of a receipt'),
      text('benefit', 'So that…', 'the expense is recorded without typing'),
      para(
        'criteria',
        'Acceptance criteria',
        'Photo is read within 5 seconds\nAmount, date and vendor are filled in\nUser can correct any field\nWorks offline and syncs later',
      ),
      para(
        'outOfScope',
        'Out of scope',
        'Multi-page invoices\nCurrency conversion',
      ),
      text(
        'metric',
        'Success metric',
        '50% of expenses added by photo within 30 days',
      ),
    ],
    template: r'''PRD: {feature}

USER STORY
As a {user}, I want to {want}, so that {benefit}.

ACCEPTANCE CRITERIA
{criteria|bullets}

OUT OF SCOPE
{outOfScope|bullets}

SUCCESS METRIC
{metric}

OPEN QUESTIONS
• Which edge cases need design?
• What data do we need to track the success metric?''',
  ),
  ToolDef(
    id: 'standup',
    name: 'Stand-up notes',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.record_voice_over_outlined,
    description: 'Yesterday, today, blockers.',
    goals: {Goal.launchApp, Goal.setUpCompany},
    itemLabel: 'Note',
    stages: ['Yesterday', 'Today', 'Blocker'],
    fields: [text('who', 'Who', 'Ada')],
    samples: [
      const SampleItem('Shipped receipt capture beta', 'Yesterday', {
        'who': 'Sam',
      }),
      const SampleItem('User interviews x3', 'Today', {'who': 'Ada'}),
      const SampleItem('Waiting on bank API keys', 'Blocker', {'who': 'Sam'}),
    ],
  ),
];
