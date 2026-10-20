import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Startup Toolkits'**
  String get appName;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get commonMore;

  /// No description provided for @commonSeePlans.
  ///
  /// In en, this message translates to:
  /// **'See plans'**
  String get commonSeePlans;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get commonCopied;

  /// No description provided for @commonLinkMissing.
  ///
  /// In en, this message translates to:
  /// **'This link is added before release.'**
  String get commonLinkMissing;

  /// No description provided for @commonEditField.
  ///
  /// In en, this message translates to:
  /// **'Edit {field}'**
  String commonEditField(String field);

  /// No description provided for @commonExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. {value}'**
  String commonExample(String value);

  /// No description provided for @goalRaiseFunding.
  ///
  /// In en, this message translates to:
  /// **'Raise funding'**
  String get goalRaiseFunding;

  /// No description provided for @goalFirstCustomers.
  ///
  /// In en, this message translates to:
  /// **'Find first customers'**
  String get goalFirstCustomers;

  /// No description provided for @goalSetUpCompany.
  ///
  /// In en, this message translates to:
  /// **'Set up the company'**
  String get goalSetUpCompany;

  /// No description provided for @goalLaunchApp.
  ///
  /// In en, this message translates to:
  /// **'Launch my app'**
  String get goalLaunchApp;

  /// No description provided for @categoryIdeaValidation.
  ///
  /// In en, this message translates to:
  /// **'Idea & validation'**
  String get categoryIdeaValidation;

  /// No description provided for @categoryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get categoryFinance;

  /// No description provided for @categoryInvestors.
  ///
  /// In en, this message translates to:
  /// **'Investor relations'**
  String get categoryInvestors;

  /// No description provided for @categoryProduct.
  ///
  /// In en, this message translates to:
  /// **'Product & project'**
  String get categoryProduct;

  /// No description provided for @categoryMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing & content'**
  String get categoryMarketing;

  /// No description provided for @categorySales.
  ///
  /// In en, this message translates to:
  /// **'Sales & customers'**
  String get categorySales;

  /// No description provided for @categoryLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal & documents'**
  String get categoryLegal;

  /// No description provided for @categoryTeam.
  ///
  /// In en, this message translates to:
  /// **'Team & HR'**
  String get categoryTeam;

  /// No description provided for @categoryGrowth.
  ///
  /// In en, this message translates to:
  /// **'Growth & analytics'**
  String get categoryGrowth;

  /// No description provided for @categoryMobileApp.
  ///
  /// In en, this message translates to:
  /// **'Mobile app founders'**
  String get categoryMobileApp;

  /// No description provided for @fieldStartupName.
  ///
  /// In en, this message translates to:
  /// **'Startup name'**
  String get fieldStartupName;

  /// No description provided for @fieldOneLiner.
  ///
  /// In en, this message translates to:
  /// **'One-line description'**
  String get fieldOneLiner;

  /// No description provided for @fieldProblem.
  ///
  /// In en, this message translates to:
  /// **'Problem'**
  String get fieldProblem;

  /// No description provided for @fieldSolution.
  ///
  /// In en, this message translates to:
  /// **'Solution'**
  String get fieldSolution;

  /// No description provided for @fieldTargetCustomer.
  ///
  /// In en, this message translates to:
  /// **'Target customer'**
  String get fieldTargetCustomer;

  /// No description provided for @fieldMarketSize.
  ///
  /// In en, this message translates to:
  /// **'Market size'**
  String get fieldMarketSize;

  /// No description provided for @fieldTraction.
  ///
  /// In en, this message translates to:
  /// **'Traction'**
  String get fieldTraction;

  /// No description provided for @fieldAsk.
  ///
  /// In en, this message translates to:
  /// **'The ask'**
  String get fieldAsk;

  /// No description provided for @fieldTeam.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get fieldTeam;

  /// No description provided for @fieldContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact email'**
  String get fieldContactEmail;

  /// No description provided for @fieldCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get fieldCash;

  /// No description provided for @fieldMonthlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Monthly expenses'**
  String get fieldMonthlyExpenses;

  /// No description provided for @fieldMonthlyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Monthly revenue'**
  String get fieldMonthlyRevenue;

  /// No description provided for @hintStartupName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Nimbly'**
  String get hintStartupName;

  /// No description provided for @hintOneLiner.
  ///
  /// In en, this message translates to:
  /// **'What you do, for whom, in one sentence'**
  String get hintOneLiner;

  /// No description provided for @hintProblem.
  ///
  /// In en, this message translates to:
  /// **'The pain your customers feel today'**
  String get hintProblem;

  /// No description provided for @hintSolution.
  ///
  /// In en, this message translates to:
  /// **'How you remove that pain'**
  String get hintSolution;

  /// No description provided for @hintTargetCustomer.
  ///
  /// In en, this message translates to:
  /// **'Who has the problem most'**
  String get hintTargetCustomer;

  /// No description provided for @hintMarketSize.
  ///
  /// In en, this message translates to:
  /// **'e.g. \$4B serviceable market'**
  String get hintMarketSize;

  /// No description provided for @hintTraction.
  ///
  /// In en, this message translates to:
  /// **'Users, revenue, growth'**
  String get hintTraction;

  /// No description provided for @hintAsk.
  ///
  /// In en, this message translates to:
  /// **'e.g. \$750k pre-seed'**
  String get hintAsk;

  /// No description provided for @hintTeam.
  ///
  /// In en, this message translates to:
  /// **'Founders and key roles'**
  String get hintTeam;

  /// No description provided for @hintContactEmail.
  ///
  /// In en, this message translates to:
  /// **'founders@yourstartup.com'**
  String get hintContactEmail;

  /// No description provided for @hintCash.
  ///
  /// In en, this message translates to:
  /// **'Cash in the bank today'**
  String get hintCash;

  /// No description provided for @hintMonthlyExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total spend per month'**
  String get hintMonthlyExpenses;

  /// No description provided for @hintMonthlyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue per month'**
  String get hintMonthlyRevenue;

  /// No description provided for @stepIdea.
  ///
  /// In en, this message translates to:
  /// **'Idea'**
  String get stepIdea;

  /// No description provided for @stepValidate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get stepValidate;

  /// No description provided for @stepMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get stepMoney;

  /// No description provided for @stepPitch.
  ///
  /// In en, this message translates to:
  /// **'Pitch'**
  String get stepPitch;

  /// No description provided for @stepLaunch.
  ///
  /// In en, this message translates to:
  /// **'Launch'**
  String get stepLaunch;

  /// No description provided for @stepIdeaAction.
  ///
  /// In en, this message translates to:
  /// **'Shape the idea'**
  String get stepIdeaAction;

  /// No description provided for @stepValidateAction.
  ///
  /// In en, this message translates to:
  /// **'Talk to customers'**
  String get stepValidateAction;

  /// No description provided for @stepMoneyAction.
  ///
  /// In en, this message translates to:
  /// **'Know your runway'**
  String get stepMoneyAction;

  /// No description provided for @stepPitchAction.
  ///
  /// In en, this message translates to:
  /// **'Tell the story'**
  String get stepPitchAction;

  /// No description provided for @stepLaunchAction.
  ///
  /// In en, this message translates to:
  /// **'Go live'**
  String get stepLaunchAction;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabProject.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get tabProject;

  /// No description provided for @tabMyTools.
  ///
  /// In en, this message translates to:
  /// **'My tools'**
  String get tabMyTools;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @welcomeGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'What are you building toward?'**
  String get welcomeGoalTitle;

  /// No description provided for @welcomeGoalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will put the right tools first. You can change this anytime.'**
  String get welcomeGoalSubtitle;

  /// No description provided for @welcomeGoalRaiseFunding.
  ///
  /// In en, this message translates to:
  /// **'Pitch deck, runway, cap table, investor pipeline'**
  String get welcomeGoalRaiseFunding;

  /// No description provided for @welcomeGoalFirstCustomers.
  ///
  /// In en, this message translates to:
  /// **'Interviews, landing page, CRM, pricing'**
  String get welcomeGoalFirstCustomers;

  /// No description provided for @welcomeGoalSetUpCompany.
  ///
  /// In en, this message translates to:
  /// **'NDA, privacy policy, contracts, invoices'**
  String get welcomeGoalSetUpCompany;

  /// No description provided for @welcomeGoalLaunchApp.
  ///
  /// In en, this message translates to:
  /// **'Store listing, ASO keywords, app privacy policy'**
  String get welcomeGoalLaunchApp;

  /// No description provided for @welcomeNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your startup'**
  String get welcomeNameTitle;

  /// No description provided for @welcomeNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every tool fills itself from this, so you only type it once.'**
  String get welcomeNameSubtitle;

  /// No description provided for @welcomeOneLinerHint.
  ///
  /// In en, this message translates to:
  /// **'Bookkeeping that does itself, for freelancers'**
  String get welcomeOneLinerHint;

  /// No description provided for @welcomeSkipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get welcomeSkipForNow;

  /// No description provided for @welcomeStart.
  ///
  /// In en, this message translates to:
  /// **'Start building'**
  String get welcomeStart;

  /// No description provided for @homeMissionControl.
  ///
  /// In en, this message translates to:
  /// **'MISSION CONTROL'**
  String get homeMissionControl;

  /// No description provided for @homeYourStartup.
  ///
  /// In en, this message translates to:
  /// **'Your startup'**
  String get homeYourStartup;

  /// No description provided for @homeSearch.
  ///
  /// In en, this message translates to:
  /// **'Search {count} tools'**
  String homeSearch(int count);

  /// No description provided for @homeSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search tools'**
  String get homeSearchLabel;

  /// No description provided for @homeLaunchPath.
  ///
  /// In en, this message translates to:
  /// **'Launch path'**
  String get homeLaunchPath;

  /// No description provided for @homeLaunchPathProgress.
  ///
  /// In en, this message translates to:
  /// **'Launch path {percent} percent complete'**
  String homeLaunchPathProgress(int percent);

  /// No description provided for @homeStepDone.
  ///
  /// In en, this message translates to:
  /// **'{step}: done'**
  String homeStepDone(String step);

  /// No description provided for @homeStepCurrent.
  ///
  /// In en, this message translates to:
  /// **'{step}: current step'**
  String homeStepCurrent(String step);

  /// No description provided for @homeStepTodo.
  ///
  /// In en, this message translates to:
  /// **'{step}: not started'**
  String homeStepTodo(String step);

  /// No description provided for @homeNextBestStep.
  ///
  /// In en, this message translates to:
  /// **'NEXT BEST STEP'**
  String get homeNextBestStep;

  /// No description provided for @homeNextAdds.
  ///
  /// In en, this message translates to:
  /// **'Adds {fields}'**
  String homeNextAdds(String fields);

  /// No description provided for @homeNextFinish.
  ///
  /// In en, this message translates to:
  /// **'Open it to finish the {step} step'**
  String homeNextFinish(String step);

  /// No description provided for @homePathComplete.
  ///
  /// In en, this message translates to:
  /// **'Launch path complete. Keep your numbers and story fresh as you grow.'**
  String get homePathComplete;

  /// No description provided for @homeStartHere.
  ///
  /// In en, this message translates to:
  /// **'Start here'**
  String get homeStartHere;

  /// No description provided for @homeStartHereGoal.
  ///
  /// In en, this message translates to:
  /// **'Start here · {goal}'**
  String homeStartHereGoal(String goal);

  /// No description provided for @homeRecentlyUsed.
  ///
  /// In en, this message translates to:
  /// **'Recently used'**
  String get homeRecentlyUsed;

  /// No description provided for @homeBrowseAll.
  ///
  /// In en, this message translates to:
  /// **'Browse all {count} tools'**
  String homeBrowseAll(int count);

  /// No description provided for @homeTrialEnded.
  ///
  /// In en, this message translates to:
  /// **'Your trial has ended'**
  String get homeTrialEnded;

  /// No description provided for @homeTrialEndedBody.
  ///
  /// In en, this message translates to:
  /// **'Open one tool a day for free, or unlock them all.'**
  String get homeTrialEndedBody;

  /// No description provided for @planTrialBadge.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{Trial · 1 day left} other{Trial · {days} days left}}'**
  String planTrialBadge(int days);

  /// No description provided for @planFree.
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get planFree;

  /// No description provided for @planPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get planPro;

  /// No description provided for @catalogTitle.
  ///
  /// In en, this message translates to:
  /// **'All {count} tools'**
  String catalogTitle(int count);

  /// No description provided for @catalogNoResults.
  ///
  /// In en, this message translates to:
  /// **'No tools match your search.'**
  String get catalogNoResults;

  /// No description provided for @myToolsTitle.
  ///
  /// In en, this message translates to:
  /// **'My tools'**
  String get myToolsTitle;

  /// No description provided for @myToolsFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get myToolsFavorites;

  /// No description provided for @myToolsFavoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Tap the star in any tool to keep it here.'**
  String get myToolsFavoritesEmpty;

  /// No description provided for @myToolsRecentEmpty.
  ///
  /// In en, this message translates to:
  /// **'Tools you open will show up here.'**
  String get myToolsRecentEmpty;

  /// No description provided for @projectTitle.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get projectTitle;

  /// No description provided for @projectNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name your startup'**
  String get projectNameEmpty;

  /// No description provided for @projectOneLinerEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a one-line description'**
  String get projectOneLinerEmpty;

  /// No description provided for @projectSetGoal.
  ///
  /// In en, this message translates to:
  /// **'Set a goal'**
  String get projectSetGoal;

  /// No description provided for @projectFilledSemantics.
  ///
  /// In en, this message translates to:
  /// **'{filled} of {total} fields filled'**
  String projectFilledSemantics(int filled, int total);

  /// No description provided for @projectFieldsFilled.
  ///
  /// In en, this message translates to:
  /// **'Fields filled'**
  String get projectFieldsFilled;

  /// No description provided for @projectFieldsFilledBody.
  ///
  /// In en, this message translates to:
  /// **'Every tool fills itself from these.'**
  String get projectFieldsFilledBody;

  /// No description provided for @projectCopyBrief.
  ///
  /// In en, this message translates to:
  /// **'Copy project brief'**
  String get projectCopyBrief;

  /// No description provided for @projectUnlockMore.
  ///
  /// In en, this message translates to:
  /// **'Add to unlock more'**
  String get projectUnlockMore;

  /// No description provided for @projectDetails.
  ///
  /// In en, this message translates to:
  /// **'Project details'**
  String get projectDetails;

  /// No description provided for @projectToolsUsing.
  ///
  /// In en, this message translates to:
  /// **'Tools that use your project'**
  String get projectToolsUsing;

  /// No description provided for @projectToolFill.
  ///
  /// In en, this message translates to:
  /// **'{filled} of {total} fields from your project'**
  String projectToolFill(int filled, int total);

  /// No description provided for @projectShowFewer.
  ///
  /// In en, this message translates to:
  /// **'Show fewer'**
  String get projectShowFewer;

  /// No description provided for @projectShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all {count}'**
  String projectShowAll(int count);

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profilePlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get profilePlan;

  /// No description provided for @profilePlanTrial.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =1{All {tools} tools are open during your free trial. 1 day left.} other{All {tools} tools are open during your free trial. {days} days left.}}'**
  String profilePlanTrial(int days, int tools);

  /// No description provided for @profilePlanFree.
  ///
  /// In en, this message translates to:
  /// **'Free plan: one tool per day. Project and onboarding stay free.'**
  String get profilePlanFree;

  /// No description provided for @profilePlanPro.
  ///
  /// In en, this message translates to:
  /// **'Pro: every tool, every day.'**
  String get profilePlanPro;

  /// No description provided for @profileManageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get profileManageSubscription;

  /// No description provided for @profilePreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profilePreferences;

  /// No description provided for @profileGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get profileGoal;

  /// No description provided for @profileNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get profileNotSet;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get profileLanguageSystem;

  /// No description provided for @profileAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileAppearance;

  /// No description provided for @profileAppearanceSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get profileAppearanceSystem;

  /// No description provided for @profileAppearanceDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get profileAppearanceDark;

  /// No description provided for @profileAppearanceLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profileAppearanceLight;

  /// No description provided for @profileMotion.
  ///
  /// In en, this message translates to:
  /// **'Motion'**
  String get profileMotion;

  /// No description provided for @profileMotionValue.
  ///
  /// In en, this message translates to:
  /// **'Follows system'**
  String get profileMotionValue;

  /// No description provided for @profileMotionNote.
  ///
  /// In en, this message translates to:
  /// **'Turn on Reduce Motion in system settings to stop animations.'**
  String get profileMotionNote;

  /// No description provided for @profileYourData.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get profileYourData;

  /// No description provided for @profileStoredOnDevice.
  ///
  /// In en, this message translates to:
  /// **'Stored on this device'**
  String get profileStoredOnDevice;

  /// No description provided for @profileStoredOnDeviceNote.
  ///
  /// In en, this message translates to:
  /// **'No account, no server. Deleting the app deletes your data.'**
  String get profileStoredOnDeviceNote;

  /// No description provided for @profileDeleteAll.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get profileDeleteAll;

  /// No description provided for @profileDeleteAllTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get profileDeleteAllTitle;

  /// No description provided for @profileDeleteAllBody.
  ///
  /// In en, this message translates to:
  /// **'Your project, tool inputs, lists and favorites will be removed from this device. This cannot be undone.'**
  String get profileDeleteAllBody;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileAbout;

  /// No description provided for @profileRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get profileRestore;

  /// No description provided for @profileVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String profileVersion(String version);

  /// No description provided for @profileLegalNote.
  ///
  /// In en, this message translates to:
  /// **'Legal templates are not legal advice.'**
  String get profileLegalNote;

  /// No description provided for @purchasesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Purchases are not available right now.'**
  String get purchasesUnavailable;

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription restored.'**
  String get restoreSuccess;

  /// No description provided for @restoreNothing.
  ///
  /// In en, this message translates to:
  /// **'No active subscription found for this account.'**
  String get restoreNothing;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Every tool.\nEvery day.'**
  String get paywallTitle;

  /// No description provided for @paywallBenefitAll.
  ///
  /// In en, this message translates to:
  /// **'All {count} tools, unlimited'**
  String paywallBenefitAll(int count);

  /// No description provided for @paywallBenefitAutofill.
  ///
  /// In en, this message translates to:
  /// **'Decks, docs and numbers that fill themselves from your project'**
  String get paywallBenefitAutofill;

  /// No description provided for @paywallBenefitPrivate.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on your device'**
  String get paywallBenefitPrivate;

  /// No description provided for @paywallUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions are not available right now. Please try again later.'**
  String get paywallUnavailable;

  /// No description provided for @paywallPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview store: placeholder prices, no real purchase.'**
  String get paywallPreview;

  /// No description provided for @paywallYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get paywallYearly;

  /// No description provided for @paywallMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get paywallMonthly;

  /// No description provided for @paywallSave.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String paywallSave(int percent);

  /// No description provided for @paywallDaysFree.
  ///
  /// In en, this message translates to:
  /// **'{days} days free'**
  String paywallDaysFree(int days);

  /// No description provided for @paywallSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get paywallSubscribe;

  /// No description provided for @paywallSubscribeFor.
  ///
  /// In en, this message translates to:
  /// **'Subscribe for {price}'**
  String paywallSubscribeFor(String price);

  /// No description provided for @paywallStartTrial.
  ///
  /// In en, this message translates to:
  /// **'Start {days}-day free trial'**
  String paywallStartTrial(int days);

  /// No description provided for @paywallPerYear.
  ///
  /// In en, this message translates to:
  /// **'{price}/year'**
  String paywallPerYear(String price);

  /// No description provided for @paywallPerMonth.
  ///
  /// In en, this message translates to:
  /// **'{price}/month'**
  String paywallPerMonth(String price);

  /// No description provided for @paywallTermsTrialYearly.
  ///
  /// In en, this message translates to:
  /// **'{days} days free, then {price} per year.'**
  String paywallTermsTrialYearly(int days, String price);

  /// No description provided for @paywallTermsTrialMonthly.
  ///
  /// In en, this message translates to:
  /// **'{days} days free, then {price} per month.'**
  String paywallTermsTrialMonthly(int days, String price);

  /// No description provided for @paywallTermsYearly.
  ///
  /// In en, this message translates to:
  /// **'{price} per year.'**
  String paywallTermsYearly(String price);

  /// No description provided for @paywallTermsMonthly.
  ///
  /// In en, this message translates to:
  /// **'{price} per month.'**
  String paywallTermsMonthly(String price);

  /// No description provided for @paywallTermsRenewal.
  ///
  /// In en, this message translates to:
  /// **'Renews automatically unless cancelled at least 24 hours before the end of the current period. Manage or cancel anytime in your {store} account settings.'**
  String paywallTermsRenewal(String store);

  /// No description provided for @paywallRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get paywallRestore;

  /// No description provided for @paywallSuccess.
  ///
  /// In en, this message translates to:
  /// **'Every tool is unlocked. Enjoy!'**
  String get paywallSuccess;

  /// No description provided for @paywallFailed.
  ///
  /// In en, this message translates to:
  /// **'The purchase did not go through. Please try again.'**
  String get paywallFailed;

  /// No description provided for @limitCountdown.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String limitCountdown(int hours, int minutes);

  /// No description provided for @limitCountdownSemantics.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours {minutes} minutes until your next free tool'**
  String limitCountdownSemantics(int hours, int minutes);

  /// No description provided for @limitToReset.
  ///
  /// In en, this message translates to:
  /// **'to reset'**
  String get limitToReset;

  /// No description provided for @limitTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used today\'s free tool'**
  String get limitTitle;

  /// No description provided for @limitBody.
  ///
  /// In en, this message translates to:
  /// **'The free plan opens one tool a day. Your project stays free.'**
  String get limitBody;

  /// No description provided for @limitBodyTool.
  ///
  /// In en, this message translates to:
  /// **'{tool} stays open all day. The free plan opens one tool a day; your project stays free.'**
  String limitBodyTool(String tool);

  /// No description provided for @limitGoUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Go unlimited'**
  String get limitGoUnlimited;

  /// No description provided for @limitTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow'**
  String get limitTomorrow;

  /// No description provided for @toolLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked on the free plan'**
  String get toolLocked;

  /// No description provided for @toolNotFound.
  ///
  /// In en, this message translates to:
  /// **'Tool not found'**
  String get toolNotFound;

  /// No description provided for @toolResetDone.
  ///
  /// In en, this message translates to:
  /// **'Back to example data'**
  String get toolResetDone;

  /// No description provided for @toolReset.
  ///
  /// In en, this message translates to:
  /// **'Reset to example'**
  String get toolReset;

  /// No description provided for @toolFavoriteAdd.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get toolFavoriteAdd;

  /// No description provided for @toolFavoriteRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get toolFavoriteRemove;

  /// No description provided for @toolProjectUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Project is already up to date'**
  String get toolProjectUpToDate;

  /// No description provided for @toolSavedFields.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Saved 1 field to your project} other{Saved {count} fields to your project}}'**
  String toolSavedFields(int count);

  /// No description provided for @toolSaveToProject.
  ///
  /// In en, this message translates to:
  /// **'Save to project'**
  String get toolSaveToProject;

  /// No description provided for @toolInputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get toolInputs;

  /// No description provided for @toolResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get toolResult;

  /// No description provided for @listAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get listAll;

  /// No description provided for @listAddItem.
  ///
  /// In en, this message translates to:
  /// **'Add {item}'**
  String listAddItem(String item);

  /// No description provided for @listNewItem.
  ///
  /// In en, this message translates to:
  /// **'New {item}'**
  String listNewItem(String item);

  /// No description provided for @listEditItem.
  ///
  /// In en, this message translates to:
  /// **'Edit {item}'**
  String listEditItem(String item);

  /// No description provided for @listDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted \"{title}\"'**
  String listDeleted(String title);

  /// No description provided for @listMoveTo.
  ///
  /// In en, this message translates to:
  /// **'Move to {stage}'**
  String listMoveTo(String stage);

  /// No description provided for @listFinalStage.
  ///
  /// In en, this message translates to:
  /// **'Final stage'**
  String get listFinalStage;

  /// No description provided for @listEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet. Tap Add to start.'**
  String get listEmpty;

  /// No description provided for @listEmptyStage.
  ///
  /// In en, this message translates to:
  /// **'Nothing in {stage}.'**
  String listEmptyStage(String stage);

  /// No description provided for @listCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy list'**
  String get listCopy;

  /// No description provided for @listStage.
  ///
  /// In en, this message translates to:
  /// **'Stage'**
  String get listStage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
