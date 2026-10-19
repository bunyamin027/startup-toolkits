import '../tool_def.dart';

/// Home "Start here" tools per onboarding goal, in the order shown.
/// `null` is for users who skipped the goal question.
const goalPicks = <Goal?, List<String>>{
  Goal.raiseFunding: [
    'pitchDeck',
    'onePager',
    'runway',
    'capTable',
    'investorTracker',
    'valuation',
  ],
  Goal.firstCustomers: [
    'interviewQuestions',
    'persona',
    'landingPage',
    'crm',
    'emailTemplates',
    'pricing',
  ],
  Goal.setUpCompany: [
    'nda',
    'privacyTerms',
    'contract',
    'invoice',
    'incomeExpense',
    'jobPost',
  ],
  Goal.launchApp: [
    'storeListing',
    'asoKeywords',
    'appPrivacy',
    'landingPage',
    'brandName',
    'roadmap',
  ],
  null: ['leanCanvas', 'runway', 'pitchDeck', 'landingPage', 'crm', 'kanban'],
};
