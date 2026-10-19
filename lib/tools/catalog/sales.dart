import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.sales;

final salesTools = <ToolDef>[
  ToolDef(
    id: 'crm',
    name: 'Mini CRM',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.contacts_outlined,
    description: 'Leads from first contact to won or lost.',
    goals: {Goal.firstCustomers},
    itemLabel: 'Lead',
    stages: ['Lead', 'Contacted', 'Demo', 'Won', 'Lost'],
    totalField: 'value',
    fields: [
      text('company', 'Company', 'Studio North', autofill: false),
      money('value', 'Deal value', 1200, autofill: false),
      text('next', 'Next step', 'Book demo'),
    ],
    samples: [
      const SampleItem('Priya Patel', 'Demo', {
        'company': 'Studio North',
        'value': 1188,
        'next': 'Demo Tue 10:00',
      }),
      const SampleItem('Marco Rossi', 'Contacted', {
        'company': 'Freelance',
        'value': 99,
        'next': 'Follow up Friday',
      }),
      const SampleItem('Hanna Berg', 'Won', {
        'company': 'Berg Design',
        'value': 594,
        'next': 'Onboarding call',
      }),
    ],
  ),
  ToolDef(
    id: 'proposal',
    name: 'Proposal template',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.request_quote_outlined,
    description: 'A clear offer with scope, price and next steps.',
    goals: {Goal.firstCustomers},
    fields: [
      text('company', 'Company name', 'Nimbly Inc.'),
      text('client', 'Client', 'Studio North', autofill: false),
      para(
        'need',
        'Client need',
        'Studio North wants its 12 freelancers to stop losing receipts.',
      ),
      para(
        'scope',
        'Scope',
        '12 Nimbly team seats for one year\nOnboarding workshop\nPriority support',
      ),
      money('price', 'Price', 2388, autofill: false),
      text('timeline', 'Timeline', 'Live within one week of signing'),
      text('valid', 'Valid until', 'Nov 30, 2026'),
      text('sender', 'Your name', 'Ada Lovelace'),
    ],
    template: r'''PROPOSAL
{company} for {client}

THE NEED
{need}

WHAT WE WILL DELIVER
{scope|bullets}

INVESTMENT
{price|money}

TIMELINE
{timeline}

NEXT STEPS
1. Reply to confirm.
2. We send the agreement and invoice.
3. Kick-off call.

This offer is valid until {valid}.

{sender}
{company}''',
  ),
  ToolDef(
    id: 'followUps',
    name: 'Follow-up reminders',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.notifications_none,
    description: 'Never forget to get back to someone.',
    goals: {Goal.firstCustomers, Goal.raiseFunding},
    itemLabel: 'Follow-up',
    stages: ['Due', 'Waiting', 'Done'],
    fields: [
      text('date', 'When', 'Friday'),
      text('note', 'Note', 'Send pricing'),
    ],
    samples: [
      const SampleItem('Priya: send demo recording', 'Due', {
        'date': 'Today',
        'note': 'Include pricing page',
      }),
      const SampleItem('Maya: partner meeting notes', 'Waiting', {
        'date': 'Thu',
        'note': 'Waiting for feedback',
      }),
      const SampleItem('Hanna: onboarding check-in', 'Done', {
        'date': 'Mon',
        'note': 'All good',
      }),
    ],
  ),
  ToolDef(
    id: 'feedback',
    name: 'Customer feedback',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.forum_outlined,
    description: 'Collect requests and close the loop.',
    goals: {Goal.firstCustomers, Goal.launchApp},
    itemLabel: 'Feedback',
    stages: ['New', 'Planned', 'Done', 'Won\'t do'],
    fields: [text('from', 'From', 'Customer'), text('votes', 'Mentions', '1')],
    samples: [
      const SampleItem('Export to CSV', 'Planned', {
        'from': 'Hanna, Marco',
        'votes': '7',
      }),
      const SampleItem('Dark mode', 'New', {'from': 'Priya', 'votes': '3'}),
      const SampleItem('Faster receipt scan', 'Done', {
        'from': 'Beta group',
        'votes': '12',
      }),
    ],
  ),
];
