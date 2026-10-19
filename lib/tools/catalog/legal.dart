import 'package:flutter/material.dart';

import '../tool_def.dart';
import 'fields.dart';

// Every legal tool sets legalDisclaimer, so DocEngine appends
// "Template only, not legal advice..." to the output (master plan §3.7).

const _cat = ToolCategory.legal;

const _privacyCommon = r'''

1. WHO WE ARE
{company} ("we") provides {service}. Contact: {email}.

2. DATA WE COLLECT
{data|bullets}

3. WHY WE USE IT
To provide and improve {service}, to support you, and to meet legal duties.

4. SHARING
We share data only with service providers that help us run {service}, under contract, and when the law requires it. We do not sell personal data.

5. RETENTION
We keep data while your account is active and delete it within {retention} after you close it, unless the law requires longer.

6. SECURITY
We use encryption in transit and at rest, and limit staff access.''';

const _termsCommon = r'''

TERMS OF USE (SUMMARY)
• You must be old enough to form a contract where you live.
• Do not misuse {service} or try to break its security.
• Paid plans renew automatically until cancelled in your account or store settings.
• {service} is provided "as is"; our liability is limited to the amount you paid in the last 12 months.
• We may update these terms and will notify you of material changes.

Effective date: {date}
Questions: {email}''';

final legalTools = <ToolDef>[
  ToolDef(
    id: 'nda',
    name: 'NDA (mutual)',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.lock_outline,
    description: 'A mutual non-disclosure agreement.',
    goals: {Goal.setUpCompany, Goal.raiseFunding},
    legalDisclaimer: true,
    fields: [
      text('company', 'Company name', 'Nimbly Inc.'),
      text('otherParty', 'Other party', 'Studio North LLC', autofill: false),
      text('purpose', 'Purpose', 'evaluating a possible partnership'),
      text('term', 'Confidentiality period', '2 years'),
      text('law', 'Governing law', 'State of Delaware'),
      text('date', 'Effective date', 'Oct 19, 2026'),
    ],
    template: r'''MUTUAL NON-DISCLOSURE AGREEMENT

This agreement is made on {date} between {company} and {otherParty} (each a "Party").

1. PURPOSE
The Parties wish to share confidential information for {purpose}.

2. CONFIDENTIAL INFORMATION
Any non-public business, technical or financial information shared by one Party with the other, in any form, that is marked confidential or would reasonably be understood as confidential.

3. OBLIGATIONS
Each Party will use the other's confidential information only for the Purpose, protect it with at least reasonable care, and share it only with people who need to know and are bound by similar duties.

4. EXCLUSIONS
Information that is public through no fault of the receiving Party, was already known to it, is independently developed, or is lawfully received from a third party.

5. TERM
These obligations last {term} from the date of disclosure.

6. RETURN OR DESTRUCTION
On request, each Party will return or destroy the other's confidential information.

7. NO LICENSE
Nothing in this agreement grants rights to the other Party's intellectual property.

8. GOVERNING LAW
This agreement is governed by the laws of the {law}.

Signed:
{company} ____________________   Date: ________
{otherParty} ____________________   Date: ________''',
  ),
  ToolDef(
    id: 'privacyTerms',
    name: 'Privacy policy & terms',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.policy_outlined,
    description: 'Privacy policy and terms for GDPR, CCPA, KVKK or global use.',
    goals: {Goal.setUpCompany, Goal.launchApp},
    legalDisclaimer: true,
    templateField: 'law',
    fields: [
      choice('law', 'Region', ['Global', 'GDPR', 'CCPA', 'KVKK']),
      text('company', 'Company name', 'Nimbly Inc.'),
      text('service', 'Service', 'the Nimbly app and website'),
      email('email', 'Contact email', 'privacy@nimbly.app'),
      para(
        'data',
        'Data collected',
        'Name and email\nBank transaction data you connect\nReceipts you upload\nApp usage analytics',
      ),
      text('retention', 'Deletion period', '30 days'),
      text('date', 'Effective date', 'Oct 19, 2026'),
    ],
    templates: {
      'Global':
          'PRIVACY POLICY: {company}$_privacyCommon'
          r'''

7. YOUR CHOICES
You can access, correct or delete your data at any time by writing to {email}.'''
          '$_termsCommon',
      'GDPR':
          'PRIVACY POLICY (EU/UK GDPR): {company}$_privacyCommon'
          r'''

7. LEGAL BASIS
Contract (to provide {service}), legitimate interests (security, product improvement) and consent (optional analytics and marketing).

8. YOUR RIGHTS
Access, rectification, erasure, restriction, portability and objection. You may withdraw consent at any time and complain to your local data protection authority. Contact: {email}.

9. INTERNATIONAL TRANSFERS
Where data leaves the EEA/UK we rely on Standard Contractual Clauses or an adequacy decision.'''
          '$_termsCommon',
      'CCPA':
          'PRIVACY POLICY (CALIFORNIA CCPA/CPRA): {company}$_privacyCommon'
          r'''

7. YOUR CALIFORNIA RIGHTS
Right to know, delete and correct personal information; right to opt out of sale or sharing; right to limit use of sensitive personal information; no discrimination for using your rights.

8. SALE AND SHARING
We do not sell or share personal information for cross-context behavioral advertising.

9. HOW TO EXERCISE RIGHTS
Email {email}. We will verify your request and respond within 45 days.'''
          '$_termsCommon',
      'KVKK':
          'AYDINLATMA METNİ / PRIVACY NOTICE (TÜRKİYE KVKK): {company}$_privacyCommon'
          r'''

7. LEGAL BASIS (KVKK ART. 5)
Performance of a contract, legal obligations, legitimate interests, and explicit consent where required.

8. YOUR RIGHTS (KVKK ART. 11)
Learn whether your data is processed, request information, request correction or deletion, object to automated results, and claim compensation. Apply to {email}; we respond within 30 days.

9. TRANSFERS ABROAD
Data is transferred abroad only under KVKK Article 9 safeguards.'''
          '$_termsCommon',
    },
  ),
  ToolDef(
    id: 'contract',
    name: 'Freelancer & partnership agreement',
    category: _cat,
    kind: ToolKind.doc,
    icon: Icons.gavel_outlined,
    description: 'Simple agreements for contractors or co-founders.',
    goals: {Goal.setUpCompany},
    legalDisclaimer: true,
    templateField: 'type',
    fields: [
      choice('type', 'Agreement type', ['Freelancer', 'Partnership']),
      text('company', 'Company name', 'Nimbly Inc.'),
      text('otherParty', 'Other party', 'Sam Rivera', autofill: false),
      para(
        'scope',
        'Scope of work or roles',
        'Design and build the iOS app MVP',
      ),
      text('fee', 'Fee or equity', r'$8,000 in two milestones'),
      text('term', 'Term', '3 months'),
      text('law', 'Governing law', 'State of Delaware'),
      text('date', 'Effective date', 'Oct 19, 2026'),
    ],
    templates: {
      'Freelancer': r'''INDEPENDENT CONTRACTOR AGREEMENT

Between {company} ("Client") and {otherParty} ("Contractor"), effective {date}.

1. SERVICES
{scope}

2. FEES
{fee}. Invoices are due within 14 days.

3. TERM
{term}, unless ended earlier by either party with 14 days' written notice.

4. INDEPENDENT CONTRACTOR
Contractor is not an employee and is responsible for their own taxes and tools.

5. INTELLECTUAL PROPERTY
On payment, all work product created under this agreement is assigned to Client.

6. CONFIDENTIALITY
Contractor keeps Client's non-public information confidential during and after this agreement.

7. GOVERNING LAW
{law}.

Signed:
{company} ____________________
{otherParty} ____________________''',
      'Partnership': r'''CO-FOUNDER / PARTNERSHIP AGREEMENT (OUTLINE)

Between the founders of {company}, including {otherParty}, effective {date}.

1. ROLES AND RESPONSIBILITIES
{scope}

2. EQUITY
{fee}. Founder shares vest over 4 years with a 1-year cliff.

3. TIME COMMITMENT
Full-time from {date}; initial term {term}, then reviewed.

4. DECISIONS
Day-to-day decisions by the responsible founder; major decisions (fundraising, hiring executives, selling the company) need all founders.

5. INTELLECTUAL PROPERTY
All company-related work is assigned to {company}.

6. LEAVING
Unvested shares return to the company; vested shares may be bought back at fair value.

7. DISPUTES
Good-faith discussion first, then mediation, under {law}.

Signed:
____________________   ____________________''',
    },
  ),
];
