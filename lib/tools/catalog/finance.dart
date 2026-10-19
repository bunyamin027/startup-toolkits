import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

const _cat = ToolCategory.finance;

final financeTools = <ToolDef>[
  ToolDef(
    id: 'runway',
    name: 'Runway & burn rate',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.local_fire_department_outlined,
    description: 'How many months until the money runs out.',
    goals: {Goal.raiseFunding, Goal.setUpCompany},
    formula: 'runway',
    heroOutput: 'runway',
    fields: [
      money('cash', 'Cash in bank', 120000, min: 0, max: 1000000, step: 5000),
      money(
        'monthlyExpenses',
        'Monthly expenses',
        14000,
        min: 0,
        max: 100000,
        step: 500,
      ),
      money(
        'monthlyRevenue',
        'Monthly revenue',
        3500,
        min: 0,
        max: 100000,
        step: 500,
      ),
    ],
  ),
  ToolDef(
    id: 'unitEconomics',
    name: 'Unit economics',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.balance,
    description: 'LTV, CAC and payback for one customer.',
    goals: {Goal.raiseFunding, Goal.firstCustomers},
    formula: 'unitEconomics',
    heroOutput: 'ltvCac',
    fields: [
      money(
        'arpu',
        'Revenue per customer / month',
        12,
        min: 1,
        max: 500,
        step: 1,
      ),
      percent('grossMargin', 'Gross margin', 80, min: 0, max: 100, step: 1),
      percent('churn', 'Monthly churn', 4, min: 0.5, max: 30, step: 0.5),
      money(
        'cac',
        'Cost to acquire a customer',
        60,
        min: 0,
        max: 2000,
        step: 5,
      ),
    ],
  ),
  ToolDef(
    id: 'pricing',
    name: 'Pricing calculator',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.sell_outlined,
    description: 'Price from cost and target margin.',
    goals: {Goal.firstCustomers, Goal.launchApp},
    formula: 'pricing',
    heroOutput: 'price',
    fields: [
      money('unitCost', 'Cost per unit', 3, min: 0, max: 500, step: 0.5),
      percent('targetMargin', 'Target margin', 75, min: 0, max: 95, step: 1),
      money(
        'competitorPrice',
        'Competitor price',
        15,
        min: 0,
        max: 1000,
        step: 1,
      ),
    ],
  ),
  ToolDef(
    id: 'invoice',
    name: 'Invoice generator',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.receipt_long_outlined,
    description: 'A clean invoice with totals and tax.',
    goals: {Goal.firstCustomers, Goal.setUpCompany},
    fields: [
      text('company', 'Company name', 'Nimbly Inc.'),
      email('email', 'Contact email', 'billing@nimbly.app'),
      text('client', 'Client', 'Studio North LLC', autofill: false),
      text('number', 'Invoice number', 'INV-0042'),
      text('date', 'Issue date', 'Oct 19, 2026'),
      text('due', 'Due date', 'Nov 18, 2026'),
      text('item1', 'Item 1', 'Onboarding workshop'),
      number('qty1', 'Item 1 quantity', 1),
      money('price1', 'Item 1 unit price', 1200, autofill: false),
      text('item2', 'Item 2', 'Annual subscription seats'),
      number('qty2', 'Item 2 quantity', 5),
      money('price2', 'Item 2 unit price', 99, autofill: false),
      percent('tax', 'Tax rate', 8),
      text(
        'payment',
        'Payment details',
        'Bank transfer to IBAN US00 0000 0000 0000',
      ),
    ],
    template: r'''INVOICE {number}

From: {company} ({email})
Bill to: {client}
Issued: {date}
Due: {due}

ITEMS
{item1}: {qty1} × {price1|money} = {=qty1 * price1|money}
{item2}: {qty2} × {price2|money} = {=qty2 * price2|money}

Subtotal: {=qty1 * price1 + qty2 * price2|money}
Tax ({tax}%): {=(qty1 * price1 + qty2 * price2) * tax / 100|money}
TOTAL DUE: {=(qty1 * price1 + qty2 * price2) * (1 + tax / 100)|money}

Payment: {payment}
Thank you for your business.''',
  ),
  ToolDef(
    id: 'capTable',
    name: 'Cap table simulator',
    category: _cat,
    kind: ToolKind.calc,
    icon: Icons.pie_chart_outline,
    description: 'Dilution and share price after a round.',
    goals: {Goal.raiseFunding},
    formula: 'capTable',
    heroOutput: 'investorStake',
    fields: [
      money(
        'preMoney',
        'Pre-money valuation',
        4000000,
        min: 250000,
        max: 50000000,
        step: 250000,
      ),
      money(
        'investment',
        'Investment',
        1000000,
        min: 50000,
        max: 20000000,
        step: 50000,
      ),
      number('existingShares', 'Existing shares', 8000000),
    ],
  ),
  ToolDef(
    id: 'incomeExpense',
    name: 'Income & expense tracker',
    category: _cat,
    kind: ToolKind.list,
    icon: Icons.account_balance_wallet_outlined,
    description: 'Money in and money out, at a glance.',
    goals: {Goal.setUpCompany},
    itemLabel: 'Entry',
    stages: ['Income', 'Expense'],
    totalField: 'amount',
    fields: [
      money('amount', 'Amount', 100, autofill: false),
      text('date', 'Date', 'Oct 1'),
      text('category', 'Category', 'Software'),
    ],
    samples: [
      const SampleItem('Subscriptions (October)', 'Income', {
        'amount': 3500,
        'date': 'Oct 31',
        'category': 'Revenue',
      }),
      const SampleItem('Salaries', 'Expense', {
        'amount': 11000,
        'date': 'Oct 28',
        'category': 'Team',
      }),
      const SampleItem('Cloud hosting', 'Expense', {
        'amount': 900,
        'date': 'Oct 3',
        'category': 'Software',
      }),
    ],
  ),
];
