import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.growth;

final growthTools = <ToolDef>[
  ToolDef(
    id: 'kpiBoard',
    name: 'KPI board',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.speed,
    description: 'The few numbers that matter, and how they are doing.',
    goals: {Goal.raiseFunding, Goal.firstCustomers},
    itemLabel: 'KPI',
    stages: ['On track', 'At risk', 'Off track'],
    fields: [text('current', 'Current', '0'), text('target', 'Target', '100')],
    samples: [
      const SampleItem('Monthly recurring revenue', 'On track', {
        'current': r'$3,500',
        'target': r'$5,000',
      }),
      const SampleItem('Trial to paid', 'At risk', {
        'current': '6%',
        'target': '8%',
      }),
      const SampleItem('Monthly churn', 'Off track', {
        'current': '7%',
        'target': '4%',
      }),
    ],
  ),
  ToolDef(
    id: 'abTest',
    name: 'A/B test significance',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.science_outlined,
    description: 'Is variant B really better, or just luck?',
    goals: {Goal.firstCustomers, Goal.launchApp},
    formula: 'abTest',
    heroOutput: 'confidence',
    fields: [
      number('visitorsA', 'Visitors A', 1000),
      number('conversionsA', 'Conversions A', 100),
      number('visitorsB', 'Visitors B', 1000),
      number('conversionsB', 'Conversions B', 130),
    ],
  ),
  ToolDef(
    id: 'funnel',
    name: 'Conversion funnel',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.filter_alt_outlined,
    description: 'Where people drop off between visit and payment.',
    goals: {Goal.firstCustomers, Goal.launchApp},
    formula: 'funnel',
    heroOutput: 'overall',
    fields: [
      number('visitors', 'Visitors', 10000),
      number('signups', 'Sign-ups', 800),
      number('active', 'Active users', 400),
      number('paying', 'Paying customers', 40),
    ],
  ),
];
