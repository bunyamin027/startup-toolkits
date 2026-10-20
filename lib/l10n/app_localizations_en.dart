// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Startup Toolkits';

  @override
  String get commonSave => 'Save';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonDone => 'Done';

  @override
  String get commonBack => 'Back';

  @override
  String get commonClose => 'Close';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonShare => 'Share';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonMore => 'More';

  @override
  String get commonSeePlans => 'See plans';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonCopied => 'Copied to clipboard';

  @override
  String get commonLinkMissing => 'This link is added before release.';

  @override
  String commonEditField(String field) {
    return 'Edit $field';
  }

  @override
  String commonExample(String value) {
    return 'e.g. $value';
  }

  @override
  String get goalRaiseFunding => 'Raise funding';

  @override
  String get goalFirstCustomers => 'Find first customers';

  @override
  String get goalSetUpCompany => 'Set up the company';

  @override
  String get goalLaunchApp => 'Launch my app';

  @override
  String get categoryIdeaValidation => 'Idea & validation';

  @override
  String get categoryFinance => 'Finance';

  @override
  String get categoryInvestors => 'Investor relations';

  @override
  String get categoryProduct => 'Product & project';

  @override
  String get categoryMarketing => 'Marketing & content';

  @override
  String get categorySales => 'Sales & customers';

  @override
  String get categoryLegal => 'Legal & documents';

  @override
  String get categoryTeam => 'Team & HR';

  @override
  String get categoryGrowth => 'Growth & analytics';

  @override
  String get categoryMobileApp => 'Mobile app founders';

  @override
  String get fieldStartupName => 'Startup name';

  @override
  String get fieldOneLiner => 'One-line description';

  @override
  String get fieldProblem => 'Problem';

  @override
  String get fieldSolution => 'Solution';

  @override
  String get fieldTargetCustomer => 'Target customer';

  @override
  String get fieldMarketSize => 'Market size';

  @override
  String get fieldTraction => 'Traction';

  @override
  String get fieldAsk => 'The ask';

  @override
  String get fieldTeam => 'Team';

  @override
  String get fieldContactEmail => 'Contact email';

  @override
  String get fieldCash => 'Cash';

  @override
  String get fieldMonthlyExpenses => 'Monthly expenses';

  @override
  String get fieldMonthlyRevenue => 'Monthly revenue';

  @override
  String get hintStartupName => 'e.g. Nimbly';

  @override
  String get hintOneLiner => 'What you do, for whom, in one sentence';

  @override
  String get hintProblem => 'The pain your customers feel today';

  @override
  String get hintSolution => 'How you remove that pain';

  @override
  String get hintTargetCustomer => 'Who has the problem most';

  @override
  String get hintMarketSize => 'e.g. \$4B serviceable market';

  @override
  String get hintTraction => 'Users, revenue, growth';

  @override
  String get hintAsk => 'e.g. \$750k pre-seed';

  @override
  String get hintTeam => 'Founders and key roles';

  @override
  String get hintContactEmail => 'founders@yourstartup.com';

  @override
  String get hintCash => 'Cash in the bank today';

  @override
  String get hintMonthlyExpenses => 'Total spend per month';

  @override
  String get hintMonthlyRevenue => 'Revenue per month';

  @override
  String get stepIdea => 'Idea';

  @override
  String get stepValidate => 'Validate';

  @override
  String get stepMoney => 'Money';

  @override
  String get stepPitch => 'Pitch';

  @override
  String get stepLaunch => 'Launch';

  @override
  String get stepIdeaAction => 'Shape the idea';

  @override
  String get stepValidateAction => 'Talk to customers';

  @override
  String get stepMoneyAction => 'Know your runway';

  @override
  String get stepPitchAction => 'Tell the story';

  @override
  String get stepLaunchAction => 'Go live';

  @override
  String get tabHome => 'Home';

  @override
  String get tabProject => 'Project';

  @override
  String get tabMyTools => 'My tools';

  @override
  String get tabProfile => 'Profile';

  @override
  String get introHeroTitle => 'Every tool your startup needs. In one app.';

  @override
  String introHeroBody(int count) {
    return '$count ready-made tools for your idea, money, investors, legal papers, marketing and launch.';
  }

  @override
  String get introStatTools => 'tools';

  @override
  String get introStatCategories => 'categories';

  @override
  String get introStatLanguages => 'languages';

  @override
  String get introStatAccounts => 'sign-ups needed';

  @override
  String get introAutofillTitle => 'Type it once. Every tool fills itself.';

  @override
  String get introAutofillBody =>
      'Your startup\'s name and story flow into pitch decks, contracts and invoices on their own.';

  @override
  String get introNumbersTitle => 'Know your numbers before investors ask.';

  @override
  String get introNumbersBody =>
      'Runway, unit economics and valuation update as you type.';

  @override
  String get introPrivate => 'No account. Your data stays on your device.';

  @override
  String get introGetStarted => 'Let\'s get started';

  @override
  String introStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get welcomeGoalTitle => 'What are you building toward?';

  @override
  String get welcomeGoalSubtitle =>
      'We will put the right tools first. You can change this anytime.';

  @override
  String get welcomeGoalRaiseFunding =>
      'Pitch deck, runway, cap table, investor pipeline';

  @override
  String get welcomeGoalFirstCustomers =>
      'Interviews, landing page, CRM, pricing';

  @override
  String get welcomeGoalSetUpCompany =>
      'NDA, privacy policy, contracts, invoices';

  @override
  String get welcomeGoalLaunchApp =>
      'Store listing, ASO keywords, app privacy policy';

  @override
  String get welcomeNameTitle => 'Tell us about your startup';

  @override
  String get welcomeNameSubtitle =>
      'Every tool fills itself from this, so you only type it once.';

  @override
  String get welcomeOneLinerHint =>
      'Bookkeeping that does itself, for freelancers';

  @override
  String get welcomeSkipForNow => 'Skip for now';

  @override
  String get welcomeStart => 'Start building';

  @override
  String get homeMissionControl => 'MISSION CONTROL';

  @override
  String get homeYourStartup => 'Your startup';

  @override
  String homeSearch(int count) {
    return 'Search $count tools';
  }

  @override
  String get homeSearchLabel => 'Search tools';

  @override
  String get homeLaunchPath => 'Launch path';

  @override
  String homeLaunchPathProgress(int percent) {
    return 'Launch path $percent percent complete';
  }

  @override
  String homeStepDone(String step) {
    return '$step: done';
  }

  @override
  String homeStepCurrent(String step) {
    return '$step: current step';
  }

  @override
  String homeStepTodo(String step) {
    return '$step: not started';
  }

  @override
  String get homeNextBestStep => 'NEXT BEST STEP';

  @override
  String homeNextAdds(String fields) {
    return 'Adds $fields';
  }

  @override
  String homeNextFinish(String step) {
    return 'Open it to finish the $step step';
  }

  @override
  String get homePathComplete =>
      'Launch path complete. Keep your numbers and story fresh as you grow.';

  @override
  String get homeStartHere => 'Start here';

  @override
  String homeStartHereGoal(String goal) {
    return 'Start here · $goal';
  }

  @override
  String get homeRecentlyUsed => 'Recently used';

  @override
  String homeBrowseAll(int count) {
    return 'Browse all $count tools';
  }

  @override
  String get homeTrialEnded => 'Your trial has ended';

  @override
  String get homeTrialEndedBody =>
      'Open one tool a day for free, or unlock them all.';

  @override
  String planTrialBadge(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Trial · $days days left',
      one: 'Trial · 1 day left',
    );
    return '$_temp0';
  }

  @override
  String get planFree => 'Free plan';

  @override
  String get planPro => 'Pro';

  @override
  String catalogTitle(int count) {
    return 'All $count tools';
  }

  @override
  String get catalogNoResults => 'No tools match your search.';

  @override
  String get myToolsTitle => 'My tools';

  @override
  String get myToolsFavorites => 'Favorites';

  @override
  String get myToolsFavoritesEmpty =>
      'Tap the star in any tool to keep it here.';

  @override
  String get myToolsRecentEmpty => 'Tools you open will show up here.';

  @override
  String get projectTitle => 'Project';

  @override
  String get projectNameEmpty => 'Name your startup';

  @override
  String get projectOneLinerEmpty => 'Add a one-line description';

  @override
  String get projectSetGoal => 'Set a goal';

  @override
  String projectFilledSemantics(int filled, int total) {
    return '$filled of $total fields filled';
  }

  @override
  String get projectFieldsFilled => 'Fields filled';

  @override
  String get projectFieldsFilledBody => 'Every tool fills itself from these.';

  @override
  String get projectCopyBrief => 'Copy project brief';

  @override
  String get projectUnlockMore => 'Add to unlock more';

  @override
  String get projectDetails => 'Project details';

  @override
  String get projectToolsUsing => 'Tools that use your project';

  @override
  String projectToolFill(int filled, int total) {
    return '$filled of $total fields from your project';
  }

  @override
  String get projectShowFewer => 'Show fewer';

  @override
  String projectShowAll(int count) {
    return 'Show all $count';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get profilePlan => 'Plan';

  @override
  String profilePlanTrial(int days, int tools) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other:
          'All $tools tools are open during your free trial. $days days left.',
      one: 'All $tools tools are open during your free trial. 1 day left.',
    );
    return '$_temp0';
  }

  @override
  String get profilePlanFree =>
      'Free plan: one tool per day. Project and onboarding stay free.';

  @override
  String get profilePlanPro => 'Pro: every tool, every day.';

  @override
  String get profileManageSubscription => 'Manage subscription';

  @override
  String get profilePreferences => 'Preferences';

  @override
  String get profileGoal => 'Goal';

  @override
  String get profileNotSet => 'Not set';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileLanguageSystem => 'System default';

  @override
  String get profileAppearance => 'Appearance';

  @override
  String get profileAppearanceSystem => 'System default';

  @override
  String get profileAppearanceDark => 'Dark';

  @override
  String get profileAppearanceLight => 'Light';

  @override
  String get profileMotion => 'Motion';

  @override
  String get profileMotionValue => 'Follows system';

  @override
  String get profileMotionNote =>
      'Turn on Reduce Motion in system settings to stop animations.';

  @override
  String get profileYourData => 'Your data';

  @override
  String get profileStoredOnDevice => 'Stored on this device';

  @override
  String get profileStoredOnDeviceNote =>
      'No account, no server. Deleting the app deletes your data.';

  @override
  String get profileDeleteAll => 'Delete all data';

  @override
  String get profileDeleteAllTitle => 'Delete all data?';

  @override
  String get profileDeleteAllBody =>
      'Your project, tool inputs, lists and favorites will be removed from this device. This cannot be undone.';

  @override
  String get profileAbout => 'About';

  @override
  String get profileRestore => 'Restore purchases';

  @override
  String get profileSupport => 'Support & feedback';

  @override
  String get profileDeveloper => 'Developer';

  @override
  String profileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get profileLegalNote => 'Legal templates are not legal advice.';

  @override
  String get purchasesUnavailable => 'Purchases are not available right now.';

  @override
  String get restoreSuccess => 'Subscription restored.';

  @override
  String get restoreNothing => 'No active subscription found for this account.';

  @override
  String get termsOfUse => 'Terms of Use (EULA)';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get paywallTitle => 'Every tool.\nEvery day.';

  @override
  String paywallBenefitAll(int count) {
    return 'All $count tools, unlimited';
  }

  @override
  String get paywallBenefitAutofill =>
      'Decks, docs and numbers that fill themselves from your project';

  @override
  String get paywallBenefitPrivate => 'Your data stays on your device';

  @override
  String get paywallUnavailable =>
      'Subscriptions are not available right now. Please try again later.';

  @override
  String get paywallPreview =>
      'Preview store: placeholder prices, no real purchase.';

  @override
  String get paywallYearly => 'Yearly';

  @override
  String get paywallMonthly => 'Monthly';

  @override
  String paywallSave(int percent) {
    return 'Save $percent%';
  }

  @override
  String paywallDaysFree(int days) {
    return '$days days free';
  }

  @override
  String get paywallSubscribe => 'Subscribe';

  @override
  String paywallSubscribeFor(String price) {
    return 'Subscribe for $price';
  }

  @override
  String paywallStartTrial(int days) {
    return 'Start $days-day free trial';
  }

  @override
  String paywallPerYear(String price) {
    return '$price/year';
  }

  @override
  String paywallPerMonth(String price) {
    return '$price/month';
  }

  @override
  String paywallTermsTrialYearly(int days, String price) {
    return '$days days free, then $price per year.';
  }

  @override
  String paywallTermsTrialMonthly(int days, String price) {
    return '$days days free, then $price per month.';
  }

  @override
  String paywallTermsYearly(String price) {
    return '$price per year.';
  }

  @override
  String paywallTermsMonthly(String price) {
    return '$price per month.';
  }

  @override
  String paywallTermsRenewal(String store) {
    return 'Renews automatically unless cancelled at least 24 hours before the end of the current period. Manage or cancel anytime in your $store account settings.';
  }

  @override
  String get paywallRestore => 'Restore Purchases';

  @override
  String get paywallSuccess => 'Every tool is unlocked. Enjoy!';

  @override
  String get paywallFailed =>
      'The purchase did not go through. Please try again.';

  @override
  String limitCountdown(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String limitCountdownSemantics(int hours, int minutes) {
    return '$hours hours $minutes minutes until your next free tool';
  }

  @override
  String get limitToReset => 'to reset';

  @override
  String get limitTitle => 'You\'ve used today\'s free tool';

  @override
  String get limitBody =>
      'The free plan opens one tool a day. Your project stays free.';

  @override
  String limitBodyTool(String tool) {
    return '$tool stays open all day. The free plan opens one tool a day; your project stays free.';
  }

  @override
  String get limitGoUnlimited => 'Go unlimited';

  @override
  String get limitTomorrow => 'Come back tomorrow';

  @override
  String get toolLocked => 'Locked on the free plan';

  @override
  String get toolNotFound => 'Tool not found';

  @override
  String get toolResetDone => 'Back to example data';

  @override
  String get toolReset => 'Reset to example';

  @override
  String get toolFavoriteAdd => 'Add to favorites';

  @override
  String get toolFavoriteRemove => 'Remove from favorites';

  @override
  String get toolProjectUpToDate => 'Project is already up to date';

  @override
  String toolSavedFields(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Saved $count fields to your project',
      one: 'Saved 1 field to your project',
    );
    return '$_temp0';
  }

  @override
  String get toolSaveToProject => 'Save to project';

  @override
  String get toolInputs => 'Inputs';

  @override
  String get toolResult => 'Result';

  @override
  String get listAll => 'All';

  @override
  String listAddItem(String item) {
    return 'Add $item';
  }

  @override
  String listNewItem(String item) {
    return 'New $item';
  }

  @override
  String listEditItem(String item) {
    return 'Edit $item';
  }

  @override
  String listDeleted(String title) {
    return 'Deleted \"$title\"';
  }

  @override
  String listMoveTo(String stage) {
    return 'Move to $stage';
  }

  @override
  String get listFinalStage => 'Final stage';

  @override
  String get listEmpty => 'Nothing here yet. Tap Add to start.';

  @override
  String listEmptyStage(String stage) {
    return 'Nothing in $stage.';
  }

  @override
  String get listCopy => 'Copy list';

  @override
  String get listStage => 'Stage';
}
