import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.team;

final teamTools = <ToolDef>[
  ToolDef(
    id: 'jobPost',
    name: 'Job post',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.work_outline,
    description: 'A job description candidates actually read.',
    goals: {Goal.setUpCompany},
    fields: [
      text('company', 'Company name', 'Nimbly'),
      text(
        'oneLiner',
        'One-liner',
        'bookkeeping that does itself, for freelancers',
      ),
      text('title', 'Job title', 'Founding Mobile Engineer'),
      text('location', 'Location', 'Remote (US time zones)'),
      text('salary', 'Salary range', r'$120k–$150k + 0.5–1% equity'),
      para(
        'responsibilities',
        'Responsibilities',
        'Own the Flutter app from design to release\nShip weekly with the founders\nShape our engineering culture',
      ),
      para(
        'requirements',
        'Requirements',
        '3+ years building mobile apps\nShipped an app to the App Store\nComfortable with ambiguity',
      ),
      para(
        'benefits',
        'Benefits',
        'Health insurance\nHome office budget\n4 weeks paid time off',
      ),
      email('email', 'Contact email', 'jobs@nimbly.app'),
    ],
    template: r'''{title} at {company}
{location} · {salary}

ABOUT US
{company} builds {oneLiner}. We are a small team that ships fast and talks to customers every week.

WHAT YOU WILL DO
{responsibilities|bullets}

WHAT WE LOOK FOR
{requirements|bullets}

WHAT WE OFFER
{benefits|bullets}

HOW TO APPLY
Send a short note and a link to something you built to {email}. No cover letter needed.

We welcome applicants of every background and identity.''',
  ),
  ToolDef(
    id: 'interviewLibrary',
    name: 'Interview question library',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.quiz_outlined,
    description: 'Structured questions by role.',
    goals: {Goal.setUpCompany},
    templateField: 'role',
    fields: [
      choice('role', 'Role', ['General', 'Engineering', 'Design', 'Sales']),
      text('company', 'Company name', 'Nimbly'),
      text('title', 'Job title', 'Founding Mobile Engineer'),
    ],
    templates: {
      'General': r'''INTERVIEW: {title} at {company}

Motivation
1. Why {company}, and why now?
2. What kind of work gives you energy?

Past behavior
3. Tell me about a project you are proud of. What was your part?
4. Describe a time you disagreed with a teammate. What happened?
5. Tell me about a mistake you made at work and what you changed after.

Startup fit
6. How do you decide what to work on when nobody tells you?
7. What would make you leave a job in the first year?

Scoring: rate each answer 1–4 right after the interview, before discussing with others.''',
      'Engineering': r'''ENGINEERING INTERVIEW: {title} at {company}

1. Walk me through the architecture of something you built. What would you change?
2. Tell me about the hardest bug you fixed. How did you find it?
3. How do you decide between shipping fast and building it right?
4. How do you test your code? What do you not test?
5. Describe a time you improved performance. How did you measure it?
6. Practical: design the data model for the core feature of {company}.
7. How do you review someone else's code?

Scoring: rate problem solving, communication and ownership 1–4.''',
      'Design': r'''DESIGN INTERVIEW: {title} at {company}

1. Walk me through a case study from problem to shipped design.
2. How did you know the design worked? What did you measure?
3. Tell me about a time research changed your mind.
4. How do you work with engineers when time is short?
5. Critique an app you use every day.
6. Practical: sketch the first-run experience of {company}.

Scoring: rate craft, product thinking and collaboration 1–4.''',
      'Sales': r'''SALES INTERVIEW: {title} at {company}

1. Walk me through your best deal: from first contact to close.
2. Tell me about a deal you lost. What would you do differently?
3. How do you build a pipeline from zero?
4. How do you qualify a lead? Which questions do you ask?
5. Role play: pitch {company} to a skeptical customer in two minutes.
6. How do you track your numbers week to week?

Scoring: rate prospecting, discovery, closing and coachability 1–4.''',
    },
  ),
  ToolDef(
    id: 'meetingNotes',
    name: 'Meeting notes & actions',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.event_note_outlined,
    description: 'Decisions and action items that get done.',
    goals: {Goal.setUpCompany},
    itemLabel: 'Action',
    stages: ['Open', 'Done'],
    fields: [
      text('owner', 'Owner', 'Ada'),
      text('due', 'Due', 'Friday'),
      text('meeting', 'Meeting', 'Weekly sync'),
    ],
    samples: [
      const SampleItem('Send investor update', 'Open', {
        'owner': 'Ada',
        'due': 'Fri',
        'meeting': 'Weekly sync',
      }),
      const SampleItem('Fix onboarding drop-off', 'Open', {
        'owner': 'Sam',
        'due': 'Wed',
        'meeting': 'Product review',
      }),
      const SampleItem('Choose payroll provider', 'Done', {
        'owner': 'Lee',
        'due': 'Mon',
        'meeting': 'Weekly sync',
      }),
    ],
  ),
  ToolDef(
    id: 'onboardingChecklist',
    name: 'Onboarding checklist',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.checklist,
    description: 'Ready-made steps for a new teammate\'s first weeks.',
    goals: {Goal.setUpCompany},
    itemLabel: 'Step',
    stages: ['To do', 'Done'],
    fields: [text('when', 'When', 'Day 1')],
    samples: [
      const SampleItem('Send offer letter and contract', 'Done', {
        'when': 'Before day 1',
      }),
      const SampleItem('Create email and tool accounts', 'To do', {
        'when': 'Before day 1',
      }),
      const SampleItem('Ship laptop and equipment', 'To do', {
        'when': 'Before day 1',
      }),
      const SampleItem('Welcome call and team intro', 'To do', {
        'when': 'Day 1',
      }),
      const SampleItem('Share mission, values and roadmap', 'To do', {
        'when': 'Day 1',
      }),
      const SampleItem('Assign an onboarding buddy', 'To do', {
        'when': 'Day 1',
      }),
      const SampleItem('First small task shipped', 'To do', {'when': 'Week 1'}),
      const SampleItem('Meet five customers or listen to calls', 'To do', {
        'when': 'Week 2',
      }),
      const SampleItem('30-day check-in', 'To do', {'when': 'Day 30'}),
    ],
  ),
];
